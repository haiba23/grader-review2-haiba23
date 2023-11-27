CPATH=".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar"

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# A directory called student-submission is created with the ListExamples.java file inside

# Then, add here code to compile and run, and do any post-processing of the
# tests

if [[ -f student-submission/ListExamples.java ]]
then
    echo "Correct file found"
else
    echo "Correct file not found"
    exit
fi

cp -r student-submission/ListExamples.java TestListExamples.java GradeServer.java Server.java lib grading-area

javac -cp $CPATH grading-area/*.java
if [[ $? -ne 0 ]]
then
    echo "Files did not compile"
    exit
else
    echo "Files successfully compiled"
fi

cd grading-area
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > test-results.txt
tests_total=`grep -oP "Tests run: \K\d+" test-results.txt`
tests_failed=`grep -oP "Failures: \K\d+" test-results.txt`
tests_passed="$((tests_total-tests_failed))"
if [[ ${#tests_total} -ne 0 ]]
then
    echo "$tests_passed tests passed out of $tests_total"
    grade=$((tests_passed/tests_total))
    echo "Grade: $grade"
else
    echo "All tests passed"
    echo "Grade: 100"
fi