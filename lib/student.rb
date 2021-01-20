class Student
    attr_accessor :name, :grade
    attr_reader :id

    def initialize(name, grade) #creates ruby objects
      @id = id
      @name = name
      @grade = grade
    end

    def self.create_table
      query = <<-TAB
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      );
      TAB
      DB[:conn].execute(query)
    end

    def self.drop_table
      query = <<-TAB
      DROP TABLE students;
      TAB
      DB[:conn].execute(query)
    end

      def save #places student data into database
        query = <<-TAB
        INSERT INTO students (name, grade)
        VALUES (?, ?);
        TAB
        DB[:conn].execute(query, self.name, self.grade)
        @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
      end

      def self.create(name:, grade:) #creates ruby objects AND saves data into db
        student = Student.new(name, grade)
        student.save
        student
      end
end
