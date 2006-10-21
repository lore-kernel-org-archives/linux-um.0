Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gb5J5-0001fN-03 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Oct 2006 18:05:47 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Gb5J3-0000Qh-AL
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Oct 2006 18:05:46 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 21 Oct 2006 03:05:37 +0200
References: <4525802F.1080900@theshore.net>
In-Reply-To: <4525802F.1080900@theshore.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610210305.37629.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.18-skas-v9-pre9 broken
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Christopher S. Aker" <caker@theshore.net>

On Thursday 05 October 2006 23:59, Christopher S. Aker wrote:
> Blaisorblade,
>
> I recently deployed a 2.6.18-skas3-v9-pre9 host, and some users weren't
> able to boot UML beyond "VFS: Mounted root (ext3 filesystem) readonly".
>   As it turns out, only 2.6-um kernels were affected, 2.4-um worked fine.
>
> This happened both in skas3 and skas0 modes.  Jeff graciously took a
> look at some straces, and his comment was that "something broke page
> fault handling generically".
>
> The traces are here:
>
> http://www.theshore.net/~caker/uml/skas2.6.18-uml_trace.txt (skas3)
> http://www.theshore.net/~caker/uml/skas2.6.18-uml_trace_skas0.txt
>
> Reverting back to a skas3-v8.2 kernel fixed it.

An important question: you reverted to a 2.6.18 + skas kernel or a 2.6.17 one? 
A similar bug is being discussed about a regression in 2.6.18 vanilla...
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
