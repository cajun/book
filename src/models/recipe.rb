# 
#  recipe.rb
#  book
#  
#  Created by Zac Kleinpeter on 2009-03-27.
#  Copyright 2009 Cajun Country. All rights reserved.
# 
class Recipe < Couch
  include HasChef
  
  property :name
  property :sections, :cast_as => [ 'Section' ], :default => []
  property :photo
  property :video
  property :state
  property :groceries, :cast_as => [ 'Grocery' ], :default => []
  property :results, :cast_as => [ 'Result' ], :default => []
  
  # ===============
  # = Validations =
  # ===============
  validates_present :name
  
  # ========================
  # = Setting up the views =
  # ========================
  view_by :name
  view_by :groceries, :map => 
    "function(doc){
      if ((doc['couchrest-type'] == 'Recipe') && doc['groceries']) {
        for( var ix in doc['groceries'] ){
          emit( doc['groceries'][ix].name,{recipe_id: doc._id, count: 1});  
        }
      }
    }
  ",
  :reduce => 
    "function( key,values,reduce){
      var count =0;
      var rec = new Array();
      var x;
      for( x in values ){
        count += values[x].count;
        rec[x] = values[x].recipe_id;
      }
      return { total: count, recipe_id: rec }
    }"
  
  # =============
  # = Callbacks =
  # =============
  save_callback :before, :can_edit?
  
  # ===============
  # = Initilizers =
  # ===============
  def initialize( args={} )
    update_associations( args ) do |params|
      super( params )
    end
  end
  
  # Update the associations from the params hash from the controller
  def update_associations( params )
    para_sections = params.delete( 'sections' )
    para_ingredients = params.delete( 'groceries' )
    
    yield( params ) if block_given? 
    
    sections_from_params( para_sections )
    groceries_from_params( para_ingredients )
  end

  def sections_from_params( params )
    return unless params
    params.each do |section_hash|
      next if section_hash.nil?
      result = detect_section( section_hash['header'] )
      if( result )
        result.text = section_hash['text']
      else
        sections << Section.new( section_hash )
      end
    end
  end
  private( :sections_from_params )
  
  def groceries_from_params( params )
    return unless params
    params.each do |groceries_hash|
      next if groceries_hash.nil?
      result = detect_groceries( groceries_hash['name'] )
      if( result )
        result.amount = groceries_hash['amount']
        result.unit = groceries_hash['unit']
      else
        groceries << Grocery.new( groceries_hash )
      end
    end
  end
  private( :groceries_from_params )
  # ===============
  # = Validations =
  # ===============
  
  # Determine who is allowed to edit this recipe
  # The base rules will only allow the creator edit the recipe
  # 
  # @returns [Boolean] this is going to be a tuf one to figure out
  def can_edit?
    true #(!Chef.current.nil? && Chef.current) == self.chef
  end

  
  # =========
  # = Utils =
  # =========
  def detect_section( section_header )
    sections.detect{ |section| section.header == section_header } 
  end
  
  def detect_groceries( name )
    groceries.detect{ |grocery| grocery.name == name } 
  end
  
  def instructions=( text )
    instructions.text = text
  end
  
  def instructions
    instr = detect_section( 'Instructions' )
    if( instr )
      instr
    else
      instr = Section.new( :header => 'Instructions' )
      sections << instr
      instr
    end
  end
end