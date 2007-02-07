Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEtPU-0007ZJ-MH for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 12:28:57 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HEtPP-0000Zv-FK
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 12:28:56 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 7 Feb 2007 21:28:09 +0100
References: <20070116215400.GK28200@knob.reflex>
In-Reply-To: <20070116215400.GK28200@knob.reflex>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200702072128.09993.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] skas3 update for linux 2.6.20-rc5
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
To: Jason Lunz <lunz@falooley.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 16 January 2007 22:54, Jason Lunz wrote:
> Between 2.6.19 and 2.6.20, an #else clause was added to the
> #ifdef !__ASSEMBLY__ in arch/i386/desc.h. This results in the skas3
> patch inserting a declaration into the assembly portion of the file.
>
> This is fixed by moving the declaration back into the proper branch of
> the #ifdef.
>
> Jason
Ok, I've uploaded 2.6.20 with this change (I'm still in a hurry with exams but 
since 2.6.20 was released I had to).

I've also thanked you at the end of the home page for your help.

Bye!
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
