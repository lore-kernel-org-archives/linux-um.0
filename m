Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Csd5n-0001Ng-B2 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Jan 2005 00:27:31 -0800
Received: from fed1rmmtao01.cox.net ([68.230.241.38])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Csd5k-0000GE-VP for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Jan 2005 00:27:31 -0800
Message-ID: <41F36014.7050905@easyco.com>
From: Doug Dumitru <doug@easyco.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] memory
References: <267988DEACEC5A4D86D5FCD780313FBB03B12C4B@exch-03.noida.hcltech.com>
In-Reply-To: <267988DEACEC5A4D86D5FCD780313FBB03B12C4B@exch-03.noida.hcltech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 23 Jan 2005 00:28:04 -0800
To: "Vaibhav Sharma, Noida" <Vaibhavs@noida.hcltech.com>, user-mode-linux-devel@lists.sourceforge.net

Vaibhav Sharma, Noida wrote:
> Hi,
> I have to build a simulator, to check the scalability limits in memory 
> management of linux. For this, the simulator  will provide a large 
> amount of RAM (in GBs), even if the amout of physical memory is only 512MB.
> 
> Can UML be used for this purpose? I had seen the "mem" option in the 
> kernel switches option of UML. Can UML simulate such a case? If it does, 
> how UML handles this? Specifically, can the UML kernel allocate all this 
> amount of memory (leaving aside the page faults which will be generated 
> in case of read/write requests to the allocated pages, for it has to use 
> the actual RAM)? Say, for example if I allocate 4 GB, will the UML 
> kernel allocate all the amount in the simulated RAM. (maybe it does it 
> in the some swap, or the /tmp, as the documentation says for the "mem" 
> usage <_http://user-mode-linux.sourceforge.net/switches.html_> . 
> 
> If I have wrong interpretation of the "mem" option in UML, please do 
> correct me.
> 
> TIA,
> Vaibhav

Mr. Sharma,

What you are trying to do will work, but not for large amounts of 
memory.  UML runs the client using a single user mode memory block as 
the entire client's core.  Thus the clients core size is limited to what 
a single task can allocate as plain memory.  With x86 architechure cpus, 
this is 2G or 3G depending on how you build a kernel (but usually 2G). 
There are no paging mechanism here so there is no way to make it "gigabytes"

Others can correct me if I have the exact numbers wrong.



-- 

--------------------------------------------------------------------
Doug Dumitru     800-470-2756     (610-237-2000)
EasyCo LLC       doug@easyco.com  http://easyco.com
--------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
