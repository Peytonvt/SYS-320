<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}


<# ******************************************************
   Function: Check Password
   Input:   1) SecureString password
   Output:  1) True if password meets requirements, False otherwise
   Requirements:
      - At least 6 characters
      - At least 1 special character
      - At least 1 number
      - At least 1 letter
********************************************************* #>
function checkPassword($password){
   
   # Convert SecureString to plain text for validation
   $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
   $plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
   
   # Check minimum length
   if($plainPassword.Length -lt 6){
      return $false
   }
   
   # Check for at least one letter
   if($plainPassword -notmatch "[a-zA-Z]"){
      return $false
   }
   
   # Check for at least one number
   if($plainPassword -notmatch "[0-9]"){
      return $false
   }
   
   # Check for at least one special character
   if($plainPassword -notmatch "[^a-zA-Z0-9]"){
      return $false
   }
   
   # Clear the plain text password from memory
   [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
   
   return $true
}
