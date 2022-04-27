﻿using Application.Interfaces.IServices.Administracion;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Services.Administracion.Login
{
    public class LoginFactory
    {
        private readonly IServiceProvider serviceProvider;

        private readonly LoginOption _loginOption;

        public LoginFactory(IServiceProvider serviceProvider, IOptions<LoginOption> loginOption)
        {
            this.serviceProvider = serviceProvider;
            _loginOption = loginOption.Value;

        }

        public ILoginService GetLoginService()
        {
            if (LoginActiveDirectory)
                return (ILoginService)serviceProvider.GetService(typeof(LoginActiveDirectoryService))!;

            return (ILoginService)serviceProvider.GetService(typeof(LoginService))!;
        }
        public bool LoginActiveDirectory
        {
            get
            {
                return _loginOption.UsarDominio;

            }
        }
    }
    public class LoginOption
    {
        public const string Schemes = "Login";
        public bool UsarDominio { get; set; }
        public string? Path { get; set; }
        public string? Domain { get; set; }
        public string? IpServer { get; set; }
    }
}
