Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Atvqe-0006hl-I4
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 13:36:44 -0800
Received: from bureau8.utcc.utoronto.ca ([128.100.132.18])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AtvlB-0007E9-CF
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 13:31:05 -0800
Message-ID: <40352B06.3030406@users.sourceforge.net>
From: kuas <ku4s@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] System Call Mechanism
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 19 Feb 2004 16:30:46 -0500
To: user-mode-linux-devel@lists.sourceforge.net

Hello,

I'm posting this question to here since this is development problem, the 
other newsgroup seems to be more like users problem and I would think 
this forum would be able to explain more about my question. I will post 
to the other newsgroup if that's the  one where I should really be posting

I'm trying to find out how the system call mechanism presently works in 
UML. I have looked into the high level description in the slides. Any 
pointers to any other documents that I might missed are appreciated.

I seems to me the new or current implementation of system call involves 
conversion from interupt 80 at the host OS into signals back in UML 
kernel. Is this the same mechanism for the current TT and SKAS? Or  TT 
mode still using ptrace thread tracing mechanism to intercept the system 
call? If there is a signal from the host to UML kernel process, there 
must be a signal handler registered by the UML kernel.

Any quick deeper overview about this mechanism would be really welcome. 
Thanks in advance.


Kuas.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
