Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zLJS-0002Te-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 16 Sep 2003 12:16:34 -0700
Received: from smtp01.web.de ([217.72.192.180] helo=smtp.web.de)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19zLJR-0001ec-S4
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Sep 2003 12:16:34 -0700
Received: from [80.128.4.71] (helo=linux)
	by smtp.web.de with esmtp (WEB.DE 4.99 #448)
	id 19zLIt-0005ey-00
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Sep 2003 21:15:59 +0200
Content-Type: text/plain; charset=utf-8; format=flowed
From: Oliver Oppitz <o.oppitz@web.de>
MIME-Version: 1.0
Message-ID: <oprvlw3zpw786kia@smtp.web.de>
Subject: [uml-devel] UML and Execution Replay
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 16 Sep 2003 21:15:25 +0200
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Hello *,

I have a new project proposal for applying UML in the deterministic (!) 
debugging of parallel programs.

This concept is not new and called execution-replay (ER): the behaviour of 
a (complicated, multi-threaded, buggy) program is recorded during an 
*execution* phase. Later during a *replay* phase the exact behaviour is 
reproduced -- including the bugs. Therefore the system is ideal to debug - 
rarely occuring bugs in parallel systems, - race conditions, - any sort of 
bugs that are (nearly) impossible to reproduce. All you need to do is to 
record the behaviour once and then simply replay and debug it! Sounds 
exciting? - you must be a hacker then ;-) And think of the consequences...
 The role of UML will be a replayable virtual machine. By recording all 
input to the UML keyboard, network, ... and feeding this same input into 
the UML during replay, the exact internal behaviour will be reproduced. One 
gets ER without modifying the code of the applications program. This is a 
huge advantage over conventional approaches that require that the software 
adheres strictly to certain protocols. Also the overhead should be minimal.

There is some more to the idea though. I presented a paper "A particular 
bug trap: Execution replay for Virtual machines" on this idea at a 
conference last week (http://aadebug2003.elis.rug.ac.be/). See link below.

I am working on the implementation myself but of course: any help is 
welcome. I will put up a small website in the next weeks and post again. If 
anyone is interested in the project already, get in contact with me via 
o.oppitz at gmx d O T net. I'd be happy to share my ideas.

Regards,

  Oliver


The paper "A particular bug trap: Execution replay for Virtual machines" 
can be found at http://213.203.244.62/paper.short.pdf
http://213.203.244.62/paper.long.pdf
Note, that there is a way to work around the limitations of the Intel 
architecture mentioned in the paper. So I am pursuing this project on x86.

Further information on Execution replay can be found at
http://www.zealcore.com/
http://www.mrtc.mdh.se/projects/getProject.php3?id=0044
The approach is different but already applied in an industrial context 
(VxWorks).





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
