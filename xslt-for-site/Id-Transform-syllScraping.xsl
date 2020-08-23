<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0"
    xpath-default-namespace="http://www.w3.org/1999/xhtml">
    
    <xsl:mode on-no-match="shallow-copy"/>
    
 <xsl:template match="meta[@name='Description']">
     <meta name="Description" content="Supported by DIGIT at Penn State Erie, The Behrend College"/>
     
 </xsl:template>
    <xsl:template match="head/link">
        <link rel="stylesheet" type="text/css" href="../syllsched.css" />
    </xsl:template>
    <xsl:template match="head/script">
        <script type="text/javascript" src="../jumpingDateLinks.js">/**/</script>
    </xsl:template>
   
   <xsl:template match="h1">
      <h1> <span class="banner">Digital Project Design</span>  </h1>  
   </xsl:template>
       
       <xsl:template match="div[@id='courseInfo']/p[1]">
           <p>
               <strong>Fall 2020</strong>
               Classes meet M W F 10:10 - 11am in Kochel 77.
           </p>
       </xsl:template>
 <xsl:template match="div[@id='courseInfo']/ol">
     <ol><li> <a href="https://www.oxygenxml.com/xml_editor.html" target="_blank">&lt;oXygen/&gt;</a>. 
        The DIGIT program has purchased a site license for this software, which
        is installed in Kochel 77 and the Lilley Library computers. The license also permits students enrolled in the
        course to install the software on their home computers (for course-related use
        only). When installing this on your own computers, <strong>you will need the
            license key</strong>, which we have posted on our course Announcements section of
        <a href="https://canvas.psu.edu" target="_blank">Canvas</a>.</li> 
         <li>All students require a good means of secure file transfer (SFTP) for homework
             assignments and projects (also available in the campus computer labs). There are
             several good options available. We recommend you download and install on your own
             computers one (or more) of the following, depending on your platform: (Feel free
             to experiment with these and others!) 
             <ul>
                 
                 <li>
                     <strong>Windows users:</strong> one of the following FTP clients—the functionality is
                     similar: 
                     <ul>
                         
                         
                         <li><a href="https://filezilla-project.org/download.php?show_all=1" target="_blank">FileZilla</a>
                             (This is our favorite client because it behaves the same way across platforms.)
                             
                         </li>
                         
                         <li><a href="http://winscp.net/eng/download.php" target="_blank">WinSCP</a> (This is one we used for a long time, since the 1990s, but we now use SSH and Filezilla
                             more frequently.)
                         </li>
                         
                         
                         <li>
                             <a href="http://www.wm.edu/offices/it/services/software/licensedsoftware/webeditingsftp/sshsecureshell/index.php" target="_blank">SSH Secure Shell Client</a>
                             
                         </li>
                         
                     </ul>
                     
                 </li>
                 
                 <li>
                     <strong>Mac users:</strong>
                     
                     <ul>
                         
                         <li><a href="https://filezilla-project.org/download.php?show_all=1" target="_blank">FileZilla</a>
                             (This is our favorite client because it behaves the same way across platforms.)
                             
                         </li>
                         
                         <li>or <a href="http://fetchsoftworks.com/fetch/" target="_blank">Fetch</a> (students
                             may obtain free licenses at <a href="http://fetchsoftworks.com/fetch/free" target="_blank">http://fetchsoftworks.com/fetch/free</a>)
                             
                         </li>
                         
                     </ul>
                     
                 </li>
                 
                 <li>
                     <strong>Linux users:</strong> You probably don’t need to install anything,
                     but look at how your system handles secure file transfer (SFTP).
                     <span class="smaller">(FileZilla or other clients designed for Linux
                         environments.)</span>
                     
                 </li>
                 
             </ul>
             
         </li>
         <li><strong>Read the <a href="index.html" target="_blank">Course Description</a></strong> and this Syllabus page to see how this course works on a day-to-day basis.
         </li>
         <li>This course fulfills a 400-level requirement for the DIGIT major at Penn State Behrend.</li>
         <li>Rusty with coding? Don‘t remember anything from DIGIT 110? Don’t worry! Past students in this course
             who never saw anything like markup or XML code have designed projects (<a href="studentProjects.html" target="_blank">like these</a>) and even spoken about them at undergraduate conferences! You will learn to develop your own digital tools and how to manage digital projects as teamwork.
         </li> 
  </ol>
    </xsl:template>
    <xsl:template match="div/ul">
        <ul>
            
            <li>
                <a href="https://newtfire.org" target="_blank">newwtFire:</a> Our project development site, where you will be publishing your projects. 
            </li>
            
            
            <li><a href="https://github.com/newtfire/digitProjectDesign-Hub" target="_blank">digitProjectDesign-Hub:
                https://github.com/newtfire/digitProjectDesign-Hub</a> Class GitHub Repository and Issues Board
            </li>
            
            
            
            <li>
                <a href="http://canvas.psu.edu" target="_blank">Canvas:
                    http://canvas.psu.edu</a> To submit homework assignments and exams, read private course announcements, access Zoom class meetings and video recordings. 
            </li>
            
            <li>
                <a href="explainFileNames.html" target="_blank">File Conventions for Canvas Homework Assignments</a>
                
            </li>
            
            <li> <a href="https://newtfire.org/courses/tutorials/" target="_blank">Explanatory Guides and Exercises: Complete List</a></li>
            
        </ul>
        
    </xsl:template>
    
    
       
</xsl:stylesheet>
    
