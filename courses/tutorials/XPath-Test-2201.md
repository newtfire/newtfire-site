Start by using "Open URL" in oXygen and opening the file at [https://dh.newtfire.org/WSGATableCh1.xml](https://dh.newtfire.org/WSGATableCh1.xml), and save the file on your computer to work with it. The XML file contains survey questions and results, coded in "Feature Structures" markup. (We will be working with this file again on the next XSLT homework exercise.) Your task in this XPath test is to work with XPath to retrieve specific information from the survey markup. **Copy and paste your XPath expressions from the oXygen window into your file to avoid mistyping!** 
(20 points: two for each sub-question.)

1. Study the file to see how the survey questions and responses are being stored in the markup. In our file, `<fs>` elements bind together each question and its response data.
   a. Write an XPath that returns all of the survey questions.   
   b. Write an XPath with a function to return a **count** of all the survey questions.
   
   c. Write an XPath to find the questions that include the word "water". (Hint: Use a string function.)

2.  Not all the questions are coded with "Yes" or "No" responses, and we want to use XPath to filter those out. 
    a. Write an XPath that returns **only** the survey items (the `<fs>` elements) that have "Yes" responses. 
    
    b. Write an XPath with a function to return a **count** of these survey items that have "Yes" responses.

3. The `@n` attributes on the `<f name='response'>` elements contain numerical tallies of each kind of survey answer.  
   a. Write an XPath that returns the number values in `@n` of all the "Yes" responses.   

   b. Modify that XPath to return the *very first* number of "Yes" responses coded in an `@n` in the file.

   c. Modify the XPath again to return only the *maximum* `@n` count of "Yes" responses in the survey. Hint: Use the max() function. What is the maximum `@n` value for "Yes"? 

5. This question is about tallying up total numbers of responses to the survey questions using the XPath `sum()` function. 
   a. First, write an XPath that returns just one `sum()` of all the `@n` values in this entire survey.
   
   b. How can we return the sums of the responses to *each individual question*?  (Hint: Write an XPath that first visits each of the `<fs>` elements, and then calculates the `sum()` of all the `f/@n` inside it. You should see 14 different sums, one for each question.)
   
BONUS: 
    a. Of all the sums you calculated in 5b, what is the maximum number of responses to any question? What XPath shows you this maximum value? (Hint: use the max() function.)

    b. Write an XPath that returns the *survey question* that yields the maximum number of responses. 
Hint: This XPath expression will need to return a question string. Also, it will need a complex predicate that filters the questions based whether the sum of all responses *equals* the maximum sum for any survey question. 


**Save this file with your last name in the file name, and upload it on Courseweb when you are finished.**






 

 
