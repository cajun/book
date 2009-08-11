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
  property :ingredients, :cast_as => [ 'Ingredient' ], :default => []
  property :results, :cast_as => [ 'Result' ], :default => []
  property :commit, :cast_as => "Commit"
  
  # ========================
  # = Setting up the views =
  # ========================
  view_by :name
  view_by :ingredients, :map => 
    "function(doc){
      if ((doc['couchrest-type'] == 'Recipe') && doc['ingredients']) {
        for( var ix in doc['ingredients'] ){
          emit( doc['ingredients'][ix].name,{recipe_id: doc._id, count: 1});  
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
  save_callback :before, :save_commit
  save_callback :before, :can_edit?
  
  # ===============
  # = Initilizers =
  # ===============
  def initialize( args={} )
    para_sections = args.delete( 'sections' )
    para_ingredients = args.delete( 'sections' )
    
    super( args )
    
    sections_from_params( para_sections )
    ingredients_from_params( para_ingredients )
  end
  
  def sections_from_params( params )
    return unless params
    params.each do |index, section_hash|
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
  
  def ingredients_from_params( params )
    return unless params
    params.each do |index, ingredient_hash|
      next if ingredient_hash.nil?
      result = detect_ingredients( ingredient_hash['name'] )
      if( result )
        result.amount = ingredient_hash['amount']
        result.unit = ingredient_hash['unit']
      else
        ingredients << Ingredient.new( ingredient_hash )
      end
    end
  end
  private( :sections_from_params )
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

  # Check to determine if this recipe is valid
  # Limited validations now for recipes
  #
  # @returns [Boolean] the succcessfullness of the save
  def valid?
    !name.nil?
  end
  
  def commit?
    false
  end
  
  def save_commit
    if commit?
      commit.save
    end
  end
  
  # =========
  # = Utils =
  # =========
  def detect_section( section_header )
    sections.detect{ |section| section.header == section_header } 
  end
  
  def detect_ingredients( name )
    ingredients.detect{ |ingredient| ingredient.name == name } 
  end
  
  def instructions=( text )
    instructions.text = text
  end
  
  def instructions
    instr = detect_ingredients( 'Instructions' )
    if( instr )
      instr
    else
      instr = Section.new( :header => 'Instructions' )
      sections << instr
      instr
    end
  end
end