pragma solidity ^0.8.0;

contract MigrantWorkersPortal {

    address Admin;
    constructor(){
        Admin = msg.sender;
    }

    struct Applicant {  
        string id;
        string name;
        string laborHistory;
        string skills;
        string availability;
        string personalDetails;
        uint rating;
    }
    
    struct Job {
        string id;
        string title;
        string description;
        string skillsRequired;
        uint salary;
    }

    Applicant[] applicants;
    Job[] jobs;

    mapping(string => uint) private LinkApplicantID;
    mapping(string => uint) private LinkJobID;

    mapping(uint256 => uint256[]) private applicantApplications;
    mapping(uint256 => uint256[]) private jobApplications;


    function checkApplicationType(string memory _id)public pure returns (string memory){
        bytes memory id = bytes(_id);
        if(id[0]=="A"){
            return "Type A";
        }
        else if(id[0]=="B"){
            return "Type B";
        }
        else {
             return "Type C";
        }
    }
    modifier AdminAcess{
        require(msg.sender==Admin,"Only Admin can Access");
        _;
    }

    modifier applicantExists(uint256 _id) {
        require(_id < applicants.length, "Applicant does not exist");
        _;
    }
    
    modifier jobExists(uint256 _id) {
        require(_id < jobs.length, "Job does not exist");
        _;
    }




    function addApplicant(
        string memory _id,
        string memory _name, 
        string memory _laborHistory, 
        string memory _skills, 
        string memory _availability, 
        string memory _personalDetails
        ) public  AdminAcess {
        LinkApplicantID[_id]=applicants.length;
        applicants.push(Applicant(_id, _name, _laborHistory, _skills, _availability, _personalDetails, 0));
    }
    
    
    function getApplicant(string memory _id) public view  applicantExists(LinkApplicantID[_id]) returns (
        string memory,
        string memory, 
        string memory, 
        string memory, 
        string memory, 
        string memory, uint256
        ) {
        Applicant memory applicant = applicants[LinkApplicantID[_id]];
        return (applicant.id, applicant.name, applicant.laborHistory, applicant.skills, applicant.availability, applicant.personalDetails, applicant.rating);
    }

    function getApplicationType(string memory _id) public view applicantExists(LinkApplicantID[_id]) returns (string memory){

        string memory Type = checkApplicationType(_id); 
        return Type;
    }

    function addJob(
        string memory _id,
        string memory _title, 
        string memory _description, 
        string memory _skillsRequired, 
        uint256 _salary
        ) public  AdminAcess { 
        LinkJobID[_id]=jobs.length;
        jobs.push(Job(_id, _title, _description, _skillsRequired, _salary));
    }

    function getJobDetails(string memory _id) public view jobExists(LinkJobID[_id]) returns (
        string memory, 
        string memory, 
        string memory, 
        string memory, 
        uint256
        ) {
        Job memory job = jobs[LinkJobID[_id]];
        return (job.id, job.title, job.description, job.skillsRequired, job.salary);
    }

    function applyForJob(string memory _applicantId, string memory  _jobId) public 
        applicantExists(LinkApplicantID[_applicantId])
        jobExists(LinkJobID[_jobId]) 
        {
        applicantApplications[LinkApplicantID[_applicantId]].push(LinkJobID[_jobId]);
        jobApplications[LinkJobID[_jobId]].push(LinkApplicantID[_applicantId]);
    }

    function provideRating(string memory _applicantId, uint256 _rating) public applicantExists(LinkApplicantID[_applicantId]) {
        require(_rating <= 5, "Rating should be between 1 and 5");
        applicants[LinkApplicantID[_applicantId]].rating = _rating;
    }

    function getApplicantRating(string memory _applicantId) public view applicantExists(LinkApplicantID[_applicantId]) returns (uint256) {
        return applicants[LinkApplicantID[_applicantId]].rating;
    }

    function getApplicationsForJob(string memory _jobId) public view jobExists(LinkJobID[_jobId]) returns (uint256[] memory) {
        return jobApplications[LinkJobID[_jobId]];
    }

    function getApplicationsByApplicant(string memory _applicantId) public view applicantExists(LinkApplicantID[_applicantId]) returns (uint256[] memory) {
        return applicantApplications[LinkApplicantID[_applicantId]];
    }
} 