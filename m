Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AewYR-0008Om-LP for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Jan 2004 05:19:59 -0800
Received: from [65.117.135.105] (helo=kartuli.timesys)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AewYR-00060C-7m
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Jan 2004 05:19:59 -0800
Message-ID: <3FFEAA6C.8020002@timesys.com>
From: "La Monte H.P. Yarroll" <piggy@timesys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] UML running on host-kernel 2.6.0 with NPTL-enabled
	glibc problem
References: <3FFE6FE3.8090303@vgertech.com>
In-Reply-To: <3FFE6FE3.8090303@vgertech.com>
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
Date: Fri, 09 Jan 2004 08:19:40 -0500
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Nuno Silva wrote:

> Hi!
>
> I've been trying for days and made lots of tests and it seems that the
> 2.4 UML binary can't run on a host with 2.6 kernel and nptl-enabled 
> glibc.
>
> I've made some tests that you can check here:
> http://sourceforge.net/mailarchive/message.php?msg_id=6897520
>
> This setup without tls+nptl (glibc compiled with
> --enable-addons=linuxthreads) works fine with UML.
>
> Sooner or later everybody will have 2.6 and the new glibc :-)
>
> Any tips? 

The calls set_thread_area(2) and get_thread_area(2) are not implemented 
in UML.
Both are essential to NPTL.  There may be other problems too...

Implementing them gets really tricky if you want UML to work with a 
2.4.x host.
I've been trying to steal enough cycles to learn enough to just 
implement them on a 2.6.0 host.

>
> Regards,
> Nuno Silva 





-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
