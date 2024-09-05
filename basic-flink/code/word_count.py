from pyflink.datastream import StreamExecutionEnvironment
from pyflink.table import StreamTableEnvironment, DataTypes
from pyflink.table.descriptors import Schema, FileSystem, OldCsv

# Initialize the execution environment
env = StreamExecutionEnvironment.get_execution_environment()
t_env = StreamTableEnvironment.create(env)

# Define the source from a local or HDFS file
source_path = "/opt/meow/input/in_file.txt"  # Replace with your file path

# Define the table schema for the file source
t_env.connect(FileSystem().path(source_path)) \
    .with_format(OldCsv().field_delimiter(' ')) \
    .with_schema(Schema().field("word", DataTypes.STRING())) \
    .create_temporary_table("sourceTable")

# Define the sink
t_env.connect(FileSystem().path('/opt/meow/output')) \
    .with_format(OldCsv()
                 .field('word', DataTypes.STRING())
                 .field('count', DataTypes.BIGINT())) \
    .with_schema(Schema()
                 .field('word', DataTypes.STRING())
                 .field('count', DataTypes.BIGINT())) \
    .create_temporary_table('mySink')

# Execute the query
t_env.from_path('sourceTable') \
    .group_by('word') \
    .select('word, count(1)') \
    .insert_into('mySink')

# Execute the job
t_env.execute("WordCountFromFile")
