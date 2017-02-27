#!/bin/bash
# Для старых систем может потребоваться указать  #!/bin/bash2.
#
# Генератор случайных паролей для bash 2.x
# Автор: Antek Sawicki <tenox@tenox.tc>,
# который великодушно позволил использовать его в данном документе.
#
# ==> Комментарии, добавленные автором документа ==>
MATRIX="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\`~!@#$%^&*()_+=-,./?\|{}[]\"':;<>"
LENGTH="20"
# ==> 'LENGTH' можно увеличить, для генерации более длинных паролей.
while [ "${n:=1}" -le "$LENGTH" ]
# ==> Напоминаю, что ":=" — это оператор "подстановки значения по-умолчанию".
# ==> Таким образом, если 'n' не инициализирована, то в нее заносится 1.
do
PASS="$PASS${MATRIX:$(($RANDOM%${#MATRIX})):1}"
# ==> Хитро, хитро....
# ==> Начнем с самых внутренних скобок...
# ==> ${#MATRIX} — возвращает длину массива MATRIX.
# ==> $RANDOM%${#MATRIX} — возвращает случайное число
# ==> в диапазоне 1 .. ДЛИНА_МАССИВА(MATRIX) - 1.
# ==> ${MATRIX:$(($RANDOM%${#MATRIX})):1}
# ==> возвращает символ из MATRIX, из случайной позиции (найденной выше).
# ==> См. подстановку параметров {var:pos:len} в Разделе 3.3.1
# ==> и примеры в этом разделе.
# ==> PASS=... — добавление символа к строке PASS, полученной на предыдущих итерациях.
# ==> Чтобы детальнее проследить ход работы цикла, раскомментируйте следующую строку
# ==>             echo "$PASS"
# ==> Вы увидите, как на каждом проходе цикла,
# ==> к строке PASS добавляется по одному символу.
let n+=1
# ==> Увеличить 'n' перед началом следующей итерации.
done
echo "$PASS"      # ==> Или перенаправьте в файл, если пожелаете.
exit 0
