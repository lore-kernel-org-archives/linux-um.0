Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ahv8M-0006YG-5c for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 10:25:22 -0800
Received: from 66-95-121-230.client.dsl.net ([66.95.121.230] helo=mail.lig.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Ahv8L-0004gJ-M0 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 10:25:21 -0800
Message-ID: <40097E0D.6020504@lig.net>
From: "Stephen D. Williams" <sdw@lig.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] What is the most up to date,
	least crashing kernel+patch?
References: <Pine.LNX.4.44.0401171208310.23425-100000@yakko.doogie.org>
In-Reply-To: <Pine.LNX.4.44.0401171208310.23425-100000@yakko.doogie.org>
Content-Type: multipart/mixed; boundary="------------030203010403060009040201"
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
Date: Sat, 17 Jan 2004 13:25:17 -0500
To: Adam Heath <adam@doogie.org>
Cc: user-mode-linux-devel@lists.sourceforge.net


This is a multi-part message in MIME format.
--------------030203010403060009040201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

What I noticed was different, and worse: large executables and reading 
large files were both slow.  Loading large executables was especially 
bad.  Python programs for instance ran ok once loaded, but there was a 
delay of several seconds while it loaded the runtime, even when it 
should have been cached.  Executables in Unix, and I think still in 
Linux, are demand paged in: the first block is loaded and executed, and 
as it tries to execute code in other blocks, they are paged in as 
needed.  This makes sense since executables are not normally linearly 
activated.  If each demand page takes inordinate time however this is a 
problem.  There may be a tweak somewhere to readahead more on executables.

I'm happy to say however that after following the suggestion to setup 
TEMPDIR to tmpfs (/dev/shm in modern convention apparently), every flies 
at a very acceptable speed.  I haven't benchmarked yet, but it is 
definitely usable now.

I also switched to a different UML kernel and lowered the memory used 
slightly which has stopped my UML kernel panics after a certain amount 
of processes and disk I/O had elapsed, sometimes only a few minutes.

The context switching problem leads to thinking about VIA architecture 
where the application bypasses the kernel to talk directly to 
virtualized devices.  In this case, that could mean UML processes 
talking more directly to the host kernel.  For network (definitely) and 
disk (maybe), this might make sense.

sdw

Adam Heath wrote:

>yOn Fri, 16 Jan 2004, Stephen D. Williams wrote:
>
>  
>
>>I have noticed that paging an executable (like Python) in takes much
>>more time that it would natively and that large amounts of disk I/O is
>>slow.  Where is the bottleneck for this and what can be done about it?
>>(I realized that the virtual layering is going to cost some.)
>>    
>>
>
>Any context switches(which includes pthreads), or io, in UML, is dog slow.
>
>A context switch underneath uml(and io as well) involes the host uml switching
>from the emulated process, into itself, and back(at the very least).
>
>With the current and forseeable UML implementations, this can't be fixed.
>You'd have to port major portitions of UML to a kernel module(this is more
>than just SKAS).
>
>  
>


-- 
swilliams@hpti.com http://www.hpti.com Personal: sdw@lig.net http://sdw.st
Stephen D. Williams 703-724-0118W 703-995-0407Fax 20147-4622 AIM: sdw


--------------030203010403060009040201
Content-Type: text/x-vcard; charset=utf8;
 name="sdw.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sdw.vcf"

begin:vcard
fn:Stephen Williams
n:Williams;Stephen
email;internet:sdw@lig.net
tel;work:703-724-0118
tel;fax:703-995-0407
tel;pager:sdwpage@lig.net
tel;home:703-729-5405
tel;cell:703-371-9362
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------030203010403060009040201--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
