# Задание

7. Наследование
Уровень: middle
Есть следующие классы:

```
package AA;
sub func { print “AA\n” }

package BB;
use parent ‘AA’;
sub func { print “BB\n”; shift->SUPER::func(@_); }

package CC;
use parent ‘AA’;
sub func { print “CC\n”; shift->SUPER::func(@_); }

package DD;
use parent qw/BB CC/;
sub func { print “DD\n”; shift->SUPER::func(@_); }
```

В каких классах и в каком порядке будут вызваны функции func, если вызвать DD->func?
По какому принципу мы должны построить наследование, если нам необходимо, чтобы при вызове DD->func, были вызваны функции по всех этих классах, и не меняя иерархию наследования?


# Пояснение

Возможно я неправильно понял задачу. Любая перестройка в наследовании приведет к изменением в иерархии. Так что единственным способом обеспечить вызов всех методов - это вручную вызывать все методы предков из @ISA.

```
package DD;
use parent qw/BB CC/;

sub func {
    print "DD\n";

    my $self = shift;

    foreach my $parent (@ISA) {
        &{ $parent . '::func' }($self);
    }
}
```
