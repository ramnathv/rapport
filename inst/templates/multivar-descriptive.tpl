<!--head
Title: Descriptives
Author: Gergely Daróczi 
Email: gergely@snowl.net
Description: This template will return descriptive statistics of numerical, or frequency tables of categorical variables. 
Packages: 
Example:    rapport('multivar-descriptive', data=ius2008, vars=c("gender", 'age'))
            rapport('multivar-descriptive', data=ius2008, vars=c("chatim", "game", "surf", "email", "download", "forum", "socnet", "xxx"))
vars          | variable[1,10] | Variables        | Categorical or numerical variables. The template will determine the measurement level of the given variable and will return detailed frequency tables or appropriate descriptive statistics for numerics. 
head-->

<%
lapply(lapply(vars, rp.name), function(x) rapport('univar-descriptive', data=rp.data, var=x))
%>
