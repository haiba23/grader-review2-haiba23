CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

# rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

student_submission="student-submission/ListExamples.java"
destination_directory="grading-area/"

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

if [[ -f $student_submission ]]; then
    echo "File found!"
    cp -r "$student_submission" "$destination_directory"
    cp -r TestListExamples.java "$destination_directory"
else
    echo "File not found: $student_submission"
    ls -R student-submission  # Add this line to list the contents of student-submission
    exit 1
fi

set +e

cd grading-area

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java
java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples


if [ $? -ne 0 ]; then
    echo "Tests compilation failed."
    exit 1
fi
