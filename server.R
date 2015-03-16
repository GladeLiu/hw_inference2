library(shiny)

shinyServer(function(input,output){
  
  output$distPlot<-renderPlot({
    library(ggplot2);
    N<-input$size; p<-input$p;
    R<-input$R; type<-input$type;
    delta_est<-rep(0,R);
    for (i in 1:R) {
      set.seed(i);
      sample1<-rbinom(N,1,p);
      hat_p<-mean(sample1);
      if(type==1){
        delta_est[i]<-hat_p/(1-hat_p);
      }else{
        delta_est[i]<-(1-hat_p)^(-4)*hat_p*(1-hat_p)/N;
      }
      
    }
    boot_est<-rep(0,R);
    B=50;boot_est<-rep(0,R);
    resam<-rep(0,B);
    for (i in 1:R) {
      set.seed(i);
      sample1<-rbinom(N,1,p);
      for(j in 1:B){
        hat_pp<-mean(sample(sample1,replace=T))
        resam[j]<-hat_pp/(1-hat_pp);
      }
      if(type==1){
        boot_est[i]<-mean(resam);
      }else{
        boot_est[i]<-var(resam);
      }      
    }
    bayes_est<-rep(0,R);
    for (i in 1:R){
      set.seed(i);
      sample1<-rbinom(N,1,p);
      t<-sum(sample1);
      if(type==1){
        bayes_est[i]<-(t+2)/(N-t+1);
      }else{
        bayes_est[i]<-(t+2)*(N+3)/((N-t+1)^2*(N-t));
      }    
    }
    if(type==1){
      Box<-data.frame(estimate=c(delta_est,boot_est,bayes_est),
                      method=c(rep('Delta',R),rep('Bootstrap',R),
                               rep('Bayes',R)),
                      type=rep('Expect',3*R));
    }else{
      Box<-data.frame(estimate=c(delta_est,boot_est,bayes_est),
                      method=c(rep('Delta',R),rep('Bootstrap',R),
                               rep('Bayes',R)),
                      type=rep('Variance',3*R));
    }

    p<-ggplot(Box,aes(x=type,y=estimate,fill=method))
    p+geom_boxplot();    
  })
})
