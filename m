Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPuFK-0001gi-6L for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Nov 2004 18:54:38 -0800
Received: from [82.154.232.218] (helo=puma-vgertech.no-ip.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CPuFI-0004hZ-1p for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Nov 2004 18:54:38 -0800
Message-ID: <418AEB71.1090005@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Fighting latency
References: <20041104155015.GA29182@gandalf.intern.marcant.net>
	<200411050044.59629.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411050044.59629.blaisorblade_spam@yahoo.it>
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
Date: Fri, 05 Nov 2004 02:54:41 +0000
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, nils toedtmann <user-mode-linux-devel@nils.toedtmann.net>

Blaisorblade wrote:

...

> A fix was proposed a while ago, which consisted in mlock()ing the memory. But 
> Jeff Dike refused it because he said "I want to write a much more complex and 
> more optimal solution. Mlock() is an hack".

Maybe having the linux binary in a ramfs will work better?
You can also do some creative mount --bind, to mount only one ramfs 
instance, if you have many UMLs running.

Regards,
Nuno Silva


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
