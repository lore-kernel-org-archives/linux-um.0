Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CxRAT-00078r-Q6 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Feb 2005 06:44:13 -0800
Received: from mail-in-09.arcor-online.net ([151.189.21.49])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CxRAT-0007b0-2c
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Feb 2005 06:44:13 -0800
Message-ID: <4204DC49.1070102@upb.de>
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
MIME-Version: 1.0
Subject: Re: Sky, comma, falling.  (Was Re: [uml-devel] Xen going to be in
	Kernel 2.6 soon?)
References: <cu189b$vnr$1@sea.gmane.org> <200502042113.13876.rob@landley.net>
In-Reply-To: <200502042113.13876.rob@landley.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Date: Sat, 05 Feb 2005 15:46:33 +0100
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

>> I feel like this is a slap in Jeff's face, since i thought 
>>that UML will be developed as the first choice in virtualizations 
>>techniques.
> 
> Yup, just like the inclusion of reiserfs in the kernel is a slap in the face 
> to ext3.  Obviously they did it just to be insulting, didn't you read Linus's 
> "I'm a bastard" speech?

No, i don't know that speech. In addition i like reiserfs, so i'm 
perhaps the wrong person to discuss that with. The next thing on the 
horizon is reiser4 - perhaps with the "files as directory" feature - 
what ever that means, but i guess i won't like it.

>>So what is it all about? When should somebody chose Xen, and when should
>>somebody chose UML? and how will UML and Xen compete?
> 
> You know, ever since the release of the BSD source code in 1992 totally 
> derailed that "Linux" project people were playing with back then, this kind 
> of question has become vitally important.  The release of any remotely 
> similar project obviously can immediately halt all development of established 
> projects that developers have sunk years of effort into, and they immediately 
> start porting over things like the COW mounts and hostfs and honeypot procfs, 
> and rewrite all the existing tutorials and retrain everybody overnight to 
> work on the new as yet untested thingy that hasn't been particularly debugged 
> yet.

So you critisize, that they don't concentrate forces on UML? I Agree.

With the integration of UML into the Linux-Kernel i thought, that it 
would speed up development of UML and make it more stable. Intead, the 
people still break the UML-stuff regularly and Jeff and Blaisorblade 
must provide patches again :-(

> Especially in a case like this, where Xen actually competes with VMWare rather 
> than UML.  Obviously, UML is doomed.  What with Xen requiring a modified host 
> kernel to provide its virtualization environment whereas UML uses the process 
> abstraction to virtualize it: I mean, who's going to use _processes_ in five 
> years, will future kernels even bother to support them?  Sure, UML not only 
> runs on an unmodified Linux kernel (even running a 2.6 UML on a 2.2 host 
> kernel), and even an effort underway to get it running on windows (who knows 
> why, but a MacOS X host can only be a matter of time), but that just means 
> maybe it can scrape on some tiny niches once it's driven off Linux by this 
> new "Adeos" thing...  Er, I mean "Plex86"...  Um...  "Xen", that's it.  And 
> obviously its original use as a Linux development tool letting you do things 
> like create a filesystem driver and mount an instance of it without 
> destablizing your host kernel, or run bits of the kernel under normal 
> userspace debugging tools...  Well, we're well rid of that, aren't we?  And 
> being to swap kernel memory to backing store just like a regular application, 
> that was obviously a bad idea from day one...

VMWare, Xen and UML are different techniques. As far as i know, UML 
doesn't use processes as the virtualization environment when running in 
SKAS mode. It runs a new kernel within a different address space - 
afaik, this is more like VMWare and Xen. But due to haveing a relatively 
normal hostsystem, there are the advantages you mentioned.

You also forgot some things: Xen doesn't support NPTL too

> Why was the question interesting again?

What's the future of Xen and UML? Will Xen grow bigger than UML? Which 
is Linus's favourite? UML or Xen?


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
