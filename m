Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ENbrK-000822-C8	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Oct 2005 12:56:54 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ENbrJ-0005FH-8l
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Oct 2005 12:56:54 -0700
Message-ID: <434581F8.1070800@theshore.net>
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] echo 0 > /proc/sysemu == failed to wait at end of
 syscall
References: <4344BF5F.8000603@theshore.net>
	<200510062115.54882.blaisorblade@yahoo.it>
In-Reply-To: <200510062115.54882.blaisorblade@yahoo.it>
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
Date: Thu, 06 Oct 2005 14:58:48 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> On Thursday 06 October 2005 08:08, Christopher S. Aker wrote:
> 
>>2.6.13.3-um
> 
> Which host, and which guest mode (SKAS0 vs. SKAS3)? 

2.6.7 with the skas patch right before the strace bug was fixed (like,
2.6.7-skas3-v4?) It's ancient, and most likely contributes to this issue.

 > And which SKAS patch (btw, any news on the host SMP crash)?

Yes, I get crashes with this kernel, too.  So, whatever it is, it's 
likely been in SKAS for a long time.

-Chris




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
