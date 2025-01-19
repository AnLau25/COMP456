%establece las formas de herencia
inherits(Subclass, Class) :- subclass(Subclass, Class).
inherits(Subclass, Ancestor) :- subclass(Subclass, Class), inherits(Class, Ancestor).

%establece los tres tipos de propriedades
property(Class, subclass_inherited, Property) :- 
    class_property(Class, subclass_inherited, Property).

property(Class, instance_inherited, Property) :- 
    class_property(Class, instance_inherited, Property).

property(Class, class_property, Property) :- 
    class_property(Class, class_property, Property).


%establece las reglas de herencia
inherited_property(Subclass, subclass_inherited, Property) :-
    inherits(Subclass, Class),
    class_property(Class, subclass_inherited, Property).

inherited_property(Instance, instance_inherited, Property) :-
    instance_of(Instance, Class),
    class_property(Class, instance_inherited, Property).

%establece la creacion de clase
class_property_query(Class, PropertyType, Property) :-
    class_property(Class, PropertyType, Property);
    (inherits(Class, SuperClass), class_property_query(SuperClass, PropertyType, Property)).

property(animal, class_property, name);
property(animal, instance_inherited, sound);
property(animal, subclass_inherited, family);

subclass(bird, animal);
subclass(canine, animal);

intance(canary, bird);
intance(wolf, canine);




