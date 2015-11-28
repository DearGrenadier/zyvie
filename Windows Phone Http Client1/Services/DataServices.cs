using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using Newtonsoft.Json;
using RestfulApplication.Models;

namespace RestfulApplication.Clients.Core.Services
{
    public class DataServices
    {

        private const string BaseUrl = "http://bc5d211c.ngrok.io/";

        public async Task<List<Employee>> GetEmployeesAsync()
        {
            var httpClient = new HttpClient();

            var jsonResponse = await httpClient.GetStringAsync(BaseUrl);

            var employeesList = await JsonConvert.DeserializeObjectAsync<List<Employee>>(jsonResponse);

            return employeesList;
        }

        public async Task AddEmployeeAsync(Employee employee)
        {
            var httpClient = new HttpClient();

            var jsonEmployee = await JsonConvert.SerializeObjectAsync(employee);

            HttpContent httpContent = new StringContent(jsonEmployee);

            httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

            httpClient.DefaultRequestHeaders.Accept
                      .Add(new MediaTypeWithQualityHeaderValue("application/json"));

            var response = await httpClient.PostAsync(new Uri(BaseUrl), httpContent);
        }

        public async Task DeleteEmmployeeAsync(Employee employee)
        {
            var httpClient = new HttpClient();

            var response = await httpClient.DeleteAsync(BaseUrl + employee.Id);
        }

        public async Task EditEmployeeAsync(Employee employee)
        {
            var httpClient = new HttpClient();

            var jsonEmployee = await JsonConvert.SerializeObjectAsync(employee);

            var httpContent = new StringContent(jsonEmployee);

            httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

            httpClient.DefaultRequestHeaders.Accept
                      .Add(new MediaTypeWithQualityHeaderValue("application/json"));

            var response = await httpClient.PutAsync(BaseUrl + employee.Id, httpContent);
        }
    }
}
