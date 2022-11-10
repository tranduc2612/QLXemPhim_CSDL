using System.Data.SqlClient;
using System.Data;
using Microsoft.SqlServer.Server;
using System;

namespace QLXemPhim
{
    internal class DBConfig
    {
        private string STRING_CONNECT = "Data Source=MSI\\SQLEXPRESS;Initial Catalog=QLXemPhim;Integrated Security=True";
        private SqlDataAdapter sqlDataAdapter; // Dùng để chèn dữ liệu vào DATA Table hoặc DataSet
        private SqlCommand sqlCommand;// Thực thi câu lệnh truy vấn

        public DataTable table(string query)
        {
            DataTable dataTable = new DataTable();
            using (SqlConnection sqlConnection = new SqlConnection(STRING_CONNECT))
            {
                sqlConnection.Open();
                sqlDataAdapter = new SqlDataAdapter(query, sqlConnection);
                sqlDataAdapter.Fill(dataTable);
                sqlConnection.Close();
            }
            return dataTable;

        }

        public void Excute(string query) // Hàm dùng để update ,insert và delete
        {
            using (SqlConnection sqlConnection = new SqlConnection(STRING_CONNECT))
            {
                sqlConnection.Open();
                sqlCommand = new SqlCommand(query, sqlConnection);
                sqlCommand.ExecuteNonQuery(); // thực thi câu truy vấn
                sqlConnection.Close();
            }
        }

        public string ExcuteProc(string nameProc,string valueParam,string inputVar,string outputVar)
        {
            using (SqlConnection sqlConnection = new SqlConnection(STRING_CONNECT))
            {
                sqlConnection.Open();
                sqlCommand = new SqlCommand();
                sqlCommand.CommandText = nameProc;
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Connection = sqlConnection;

                SqlParameter param = new SqlParameter();
                param.ParameterName = inputVar;
                param.Value = valueParam;
                param.Direction = ParameterDirection.Input;
                sqlCommand.Parameters.Add(param);

                SqlParameter output = new SqlParameter();
                output.ParameterName = outputVar;
                output.Direction = ParameterDirection.Output;
                output.Size = 10;
                sqlCommand.Parameters.Add(output);

                sqlCommand.ExecuteNonQuery(); // thực thi câu truy vấn
                sqlConnection.Close();

                return output.Value.ToString();
            }
        }
    }
}