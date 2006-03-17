Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FKKnJ-0003kw-Hw for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2006 11:39:29 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FKKnI-00007K-E5
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2006 11:39:30 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] compile failure on uml-2.6.15-bs3-tls (and an easy
	fix)
References: <20060317185723.GA8310@cobalt.cs.wisc.edu>
In-Reply-To: <20060317185723.GA8310@cobalt.cs.wisc.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603172039.21942.blaisorblade@yahoo.it>
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
Date: Fri, 17 Mar 2006 20:39:21 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Erik Paulson <epaulson@cs.wisc.edu>

On Friday 17 March 2006 19:57, Erik Paulson wrote:
> Hello,
>
> On a CentOS 4.2 machine, I had the same failure that Bill Stearns had
> back in January in this message:
>
> http://www.mail-archive.com/user-mode-linux-devel@lists.sourceforge.net/msg
>02943.html

Ah, ok... here's why he posted that patch. Thanks for the report, I had 
integrated it anyway in my tree for next release, but I didn't know it fixed 
a bug - RH headers are different so I didn't experience this problem.

Fix will be in -bb5 and subsequent release.

> (the failure:
>
> arch/um/os-Linux/tls.c:48: error: syntax error before 'get_thread_area'
> arch/um/os-Linux/tls.c:48: warning: type defaults to 'int' in declaration
> of '_syscall1'
> )
>
> The small addition of #include <linux/unistd.h> fixed it for me.
>
> Here's how I built my kernel:

> teal(40)% rpm -qa | grep glibc
> glibc-utils-2.3.4-2.13
> glibc-common-2.3.4-2.13
> glibc-headers-2.3.4-2.13
> glibc-2.3.4-2.13
> glibc-devel-2.3.4-2.13
> glibc-kernheaders-2.4-9.1.98.EL

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
