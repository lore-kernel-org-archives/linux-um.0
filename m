Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPrIn-0005tu-3g for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Nov 2004 15:46:01 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CPrIl-0006kM-1T for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Nov 2004 15:46:00 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Fighting latency
References: <20041104155015.GA29182@gandalf.intern.marcant.net>
In-Reply-To: <20041104155015.GA29182@gandalf.intern.marcant.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411050044.59629.blaisorblade_spam@yahoo.it>
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
Date: Fri, 5 Nov 2004 00:44:59 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: nils toedtmann <user-mode-linux-devel@nils.toedtmann.net>

On Thursday 04 November 2004 16:50, nils toedtmann wrote:
> Moin,
>
> in some UMLs i run services which do not like latency, eg. VoIP- and
> gameserver. I previously observed my UMLs going into meditation for a split
> second every few seconds, but that bucking almost disappeard by taking the
> usual tuning steps (SKAS, sysemu, $TMP on tmpfs). Nevertheless, my UMLs are
> still not as responsive as i would like them to. It's not a matter of CPU
> or network performance. Host and guest are >=95% idle all the time,
> bandwidth use is far from my UML-bench- marks.
>
> I tried to renice the UML processes, but seems not to help (it's hard to
> measure, just the "feeling" while listening to audio or onlinegaming).
>
> Any suggestions?
>
> I enabled "PREEMPT" in host kernel. Maybe that's a bad idea?

This problem is an old one. Search the archives for "odd ping problems", which 
is about long ping delay.

A fix was proposed a while ago, which consisted in mlock()ing the memory. But 
Jeff Dike refused it because he said "I want to write a much more complex and 
more optimal solution. Mlock() is an hack".

Even so, I'll try to update the patch, fix it on the security side (that one 
required setuid()'ing UML, which is purposeless) and push it for inclusion, 
if possible.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
