Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQJkv-0003n6-2Q for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 22:08:57 -0800
Received: from adsl-b5-232-218.telepac.pt ([82.154.232.218]
	helo=puma-vgertech.no-ip.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CQJkt-0000LG-Cs for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 22:08:56 -0800
Message-ID: <418C6A72.4080807@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Fighting latency
References: <20041104155015.GA29182@gandalf.intern.marcant.net>
	<200411050044.59629.blaisorblade_spam@yahoo.it>
	<418AEB71.1090005@vgertech.com>
	<200411052038.15491.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411052038.15491.blaisorblade_spam@yahoo.it>
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
Date: Sat, 06 Nov 2004 06:08:50 +0000
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, nils toedtmann <user-mode-linux-devel@nils.toedtmann.net>

Blaisorblade wrote:
>>Maybe having the linux binary in a ramfs will work better?
> 
> Wise idea! But you forgot the UML "RAM" from $TMPDIR.

No i didn't :-) And i advise against it because of the problems that you 
point out below (OOM). Anyway, if the data is frequently used it won't 
be sent to swap... If you only touch that data once every 5 minutes and 
you have some memory pressure you may get a bigger latency.

If you must have fast-as-it-gets memory access making several UBDs, one 
of them very small in ramfs, may be better, YMMV.

...

>>You can also do some creative mount --bind, to mount only one ramfs
>>instance, if you have many UMLs running.
> 
> Not needed I think - use different names for UML binaries as needed. It will 
> pickup a good name for the RAM file.

I was thinking about chroot environments. And saving some MB by using 
the same binary - living in ramfs - to run many UMLs.

Regarding double-cacheing you may try NFS or directIO (with directIO the 
guest can create disk I/O even if it's not needed and ruin the host's 
I/O performance). Again, YMMV.

Thanks,
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
