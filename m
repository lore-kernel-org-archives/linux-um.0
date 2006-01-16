Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eya6l-0006ZP-9w for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 11:33:39 -0800
Received: from wproxy.gmail.com ([64.233.184.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Eya6k-00050D-RK
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 11:33:39 -0800
Received: by wproxy.gmail.com with SMTP id i30so1175425wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 16 Jan 2006 11:33:36 -0800 (PST)
Message-ID: <43CBF532.8020103@gmail.com>
From: Jacob Bachmeyer <jcb62281@gmail.com>
Reply-To: jcb62281@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] SKAS4 design question
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
Date: Mon, 16 Jan 2006 13:34:10 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jcb62281@gmail.com

Has any thought been given to making SKAS4 suitably generic that it 
could be used for more than just UML?

I'm thinking of some arrangement where one process can handle multiple 
address spaces for multiple other processes.

This would have greater application than merely UML--for example, Wine 
could also be adapted to use SKAS, potentially a killer app, as this 
could make Wine more secure than Windows.  (Running all Wine code in its 
own address space, separate from the apps Wine runs, could insulate 
against some application buffer overruns.  (due to the way the Win32 API 
is accessed))

Hmm, what would we need for this to work?

--ability to create/release "remote" address spaces
--read/write in those "remote" address spaces
-- possibly even capability to map a section of a "remote" address space 
into the control process, do something, then release it
--ability to configure pages in a "remote" address space such that 
accesses trap to the control process
--ability to trap all possible syscalls from such an address space
for the big bonus:
--ability to use either the host scheduler or some code from the 
not-yet-developed libUML to run threads in the "remote" address spaces

Hmm, with a little more effort, this could become a generic 
compatibility layer for non-Linux programs--for each foreign platform, 
one would need only a control program that manages the foreign processes 
and implements the foreign syscalls.

{Contemplates HURD on Linux :-)}

As I understand it, the Linux mm system is internally moving in this 
kind of direction already.  SKAS would become primarily a system by 
which pages can have backing store implemented in userspace and "remote" 
address spaces managed.

This direction would certainly help push SKAS into the stock kernel.

PS:  If I understand correctly, UML with the current SKAS3 works by 
swapping processes into and out of a single "user" address space.  I 
propose a system where many distinct "user" address spaces are 
maintained by the kernel and execution is placed whereever the user-mode 
scheduler says.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
