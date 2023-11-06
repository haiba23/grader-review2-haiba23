CPATH=".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar"

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

cp student-submission/ListExamples.java TestListExamples.java GradeServer.java Server.java grading-area

javac -cp $CPATH grading-area/*.java
if [[ $? -eq 126 ]]
then
    echo "Files did not compile"
    exit
else
    echo "Files successfully compiled"
fi

java -cp $CPATH org.junit.runner.JUnitCore grading-area/TestListExamples.java > grading-area/test-results.txt
tests_total=`grep -oP "Tests run: \K\d+" grading-area/test-results.txt`
tests_failed=`grep -oP "Failures: \K\d+" grading-area/test-results.txt`
tests_passed=$(($tests_total - $tests_failed));
echo "$tests_passed tests passed out of $tests_total"
grade=$(($tests_passed/$tests_total))
echo "Grade: $grade"