CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission
if [[ -f ListExamples.java ]]
then
    echo "ListExamples.java found"
else
    echo "need ListExamples.java"
    exit 1
fi


cp ../TestListExamples.java ./
cp -R ../lib ./
echo "The tester file is copied over to the student-submission dir"

javac -cp $CPATH *.java 2> error.txt
if [[ $? -eq 0 ]]
then
    echo "the code compiles successfully"
else
    cat error.txt
fi

java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > test_fail.txt

cat test_fail.txt


