Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPjsW-0000KX-6m for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Nov 2004 07:50:24 -0800
Received: from rossini.marcant.net ([217.14.160.189] helo=admins.marcant.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPjsT-0005QG-N8 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Nov 2004 07:50:24 -0800
From: nils toedtmann <user-mode-linux-devel@nils.toedtmann.net>
Message-ID: <20041104155015.GA29182@gandalf.intern.marcant.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Fighting latency
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
Date: Thu, 4 Nov 2004 16:50:16 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Moin,

in some UMLs i run services which do not like latency, eg. VoIP- and gameserver. 
I previously observed my UMLs going into meditation for a split second every few 
seconds, but that bucking almost disappeard by taking the usual tuning steps 
(SKAS, sysemu, $TMP on tmpfs). Nevertheless, my UMLs are still not as responsive 
as i would like them to. It's not a matter of CPU or network performance. Host
and guest are >=95% idle all the time, bandwidth use is far from my UML-bench-
marks.

I tried to renice the UML processes, but seems not to help (it's hard to measure,
just the "feeling" while listening to audio or onlinegaming). 

Any suggestions?

I enabled "PREEMPT" in host kernel. Maybe that's a bad idea?

/nils.

-- 
there is no sig.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
