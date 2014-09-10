Feature: Scans application for packages and classes
    As a CS teacher
    I want to test students' programming assignments
    In order to find out if classes have been correctly created

    Background:
        Given the maximum grade is 2
        Given the main class is 'Avaliacao5'
        Given I set the script timeout to 10000
        Given I evaluate 'import utfpr.ct.dainf.grader.*;'
        Given I evaluate 'import utfpr.ct.dainf.if62c.avaliacao.*;'
        Given I evaluate 'String testDataPath = ClassLoader.getSystemClassLoader().getResource("testdata.txt").getFile();'
        Given I evaluate 'String testFile1Path = ClassLoader.getSystemClassLoader().getResource("test1.txt").getFile();'
        Given I evaluate 'String testFile2Path = ClassLoader.getSystemClassLoader().getResource("test2.txt").getFile();'
        Given I evaluate 'testDataFile = new java.io.File(testDataPath);'
        Given I evaluate 'testFile1 = new java.io.File(testFile1Path);'
        Given I evaluate 'testFile2 = new java.io.File(testFile2Path);'
    
    Scenario: Find public static void main(String[]) (0.2)
        Given I report 'STARTING GRADING...'
        Given I report 'GRADING TASK 1...'
        Given class 'Avaliacao5' exists somewhere store class in <mainClass>
        And class <mainClass> declares 'main(java.lang.String[])' method save in <mainMethod>
        And method <mainMethod> returns type 'void'
        And member <mainMethod> has 'public' modifier
        And member <mainMethod> has 'static' modifier
        Then award .2 points

    Scenario: Check class Ordenador (0.3)
        Given I report 'GRADING TASK 2...'
        Given class 'Ordenador' exists somewhere store class in <ordenadorClass>
        And I import <ordenadorClass>
        And the class <ordenadorClass> is in the 'utfpr.ct.dainf.if62c.avaliacao' package
        And class <ordenadorClass> is assignable from 'java.lang.Thread'
        Then award .1 points
        Given class <ordenadorClass> declares 'Ordenador(java.lang.String)' constructor save in <ordenadorConstructor>
        And member <ordenadorConstructor> has 'public' modifier
        Then award .1 points
        Given class <ordenadorClass> declares 'run()' method save in <runMethod>
        And method <runMethod> returns type 'void'
        And member <runMethod> has 'public' modifier
        Then award .1 points

    Scenario: Check private Ordenador.carrega() (0.4)
        Given I report 'GRADING TASK 3...'
        Given class <ordenadorClass> declares 'carrega()' method save in <carregaMethod>
        And method <carregaMethod> returns type 'void'
        And member <carregaMethod> has 'private' modifier
        Then award .15 points
        Given I set <carregaMethod> accessible
        And I evaluate 'Ordenador ordTest = new Ordenador(testDataPath)'
        And I evaluate 'carregaMethod.invoke(ordTest, null)'
        Then award .25 points

    Scenario: Check private Ordenador.grava() (0.4)
        Given I report 'GRADING TASK 4...'
        Given class <ordenadorClass> declares 'grava()' method save in <gravaMethod>
        And method <gravaMethod> returns type 'void'
        And member <gravaMethod> has 'private' modifier
        Then award .15 points
        Given I set <gravaMethod> accessible
        And I evaluate 'gravaMethod.invoke(ordTest, null)'
        And I evaluate 'String testOrdPath = ClassLoader.getSystemClassLoader().getResource("testdata.txt.ord").getFile();'
        And I evaluate 'java.io.File ordFile = new java.io.File(testOrdPath)'
        And expression 'ordFile.isFile()' evaluates to <true>
        Then award .25 points

    Scenario: Check private Ordenador.ordena() (0.4)
        Given I report 'GRADING TASK 5...'
        Given I evaluate 'if (ordFile.exists()) ordFile.delete();'
        Given class <ordenadorClass> declares 'ordena()' method save in <ordenaMethod>
        And method <ordenaMethod> returns type 'void'
        And member <ordenaMethod> has 'public' modifier
        Then award .15 points
        And I evaluate 'ordenaMethod.invoke(ordTest, null)'
        And I evaluate 'String testOrdPath = ClassLoader.getSystemClassLoader().getResource("testdata.txt.ord").getFile();'
        And I evaluate 'java.io.File ordFile = new java.io.File(testOrdPath)'
        And I report <ordFile.getAbsolutePath()>
        And expression 'ordFile.isFile()' evaluates to <true>
        Then award .25 points

    Scenario: Check output (0.3)
        Given I report 'GRADING TASK 6...'
        Given  I evaluate 'inTestStream = new java.io.ByteArrayInputStream((testFile1.getAbsolutePath() + "\n" + testFile2.getAbsolutePath() + "\n\n").getBytes())'
        Given I set input from stream <inTestStream>
        Given I set output to <outstr>
        And I evaluate '(new Avaliacao5()).main(new String[0])'
        Given I set input from stream <default>
        Given I set output to <default>
        And I report <outstr>
        And <outstr> matches regex '.+2\s+arquivo.*' with 'Pattern.DOTALL' option
        Then award .3 points


    Scenario: Report final grade.
        Given I report grade formatted as 'FINAL GRADE: %.1f'
