function getParameters(classifier,cv_setting,ds)
% INPUT:
%  classifier:  algorithm to be used for DTI prediction
%  cv_setting:  cross validation setting used (S1/S2/S3)
%  ds:          dataset (4:NR, 3:GPCR, 2:IC, 1:E)

global num_iter k lambda_l lambda_d lambda_t

switch classifier
    case 'splcmf'
        num_iter = 2;
        switch cv_setting
            
            case 'S1'
                switch(ds)
                    case 4
                        k = 100;
                        lambda_l = 0.125;
                        lambda_d = 0.125;
                        lambda_t = 0.125;
                        
                    case 3
                        num_iter = 1;
                        k = 100;
                        lambda_l = 1;
                        lambda_d = 0.5;
                        lambda_t = 0.25;
                        
                    case 2
                        num_iter = 1;
                        k = 100;
                        lambda_l = 1;
                        lambda_d = 0.5;
                        lambda_t = 0.5;
                        
                    case 1
                        k = 100;
                        lambda_l = 2;
                        lambda_d = 0.25;
                        lambda_t = 2;
                end
                
            case 'S2'
                switch(ds)
                    case 4
                        num_iter = 2;
                        k = 10;
                        lambda_l = 0.125/2;
                        lambda_d = 4;
                        lambda_t = 0.0625;
                        
                    case 3
                        k = 32;
                        lambda_l = 0.25;
                        lambda_d = 32;
                        lambda_t = 0.0625;
                        
                    case 2
                        k=60
                        lambda_l = 2;
                        lambda_d = 32;
                        lambda_t = 0.25;
                        
                    case 1
                        num_iter = 1;
                        k=100;
                        lambda_l = 2;
                        lambda_d = 64;
                        lambda_t = 0.125;
                end
                
            case 'S3'
                switch(ds)
                    case 4
                        num_iter = 6;
                        k=100;
                        lambda_l = 0.5;
                        lambda_d = 0.0625;
                        lambda_t = 32;
                        
                    case 3
                        num_iter = 3;
                        k=110;
                        lambda_l = 0.125;
                        lambda_d = 0.125;
                        lambda_t = 0.125;
                        
                    case 2
                        num_iter = 2;
                        k=100;
                        lambda_l = 2;
                        lambda_d = 0.0625;
                        lambda_t = 64;
                        
                    case 1
                        num_iter = 3;
                        k=100;
                        lambda_l = 0.125;
                        lambda_d = 0.0625;
                        lambda_t = 0.0625;
                end
                
        end
        fprintf('lambda_l=%g, lambda_d=%g, lambda_t=%g\n', lambda_l, lambda_d, lambda_t)
        
end

end