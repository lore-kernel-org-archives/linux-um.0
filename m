Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ak1Rk-00073d-8b for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 05:34:04 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Ak1Rj-0002TS-O7
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 05:34:03 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20040123135647.GA6768@ccure.user-mode-linux.org>
References: <20040120191706.GA32711@elte.hu> <20040120194328.GA1518@elte.hu>
	<20040120200105.GA2289@elte.hu> <20040122162139.GA28167@elte.hu>
	<20040123093541.GA21763@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123093541.GA21763@elte.hu>
Subject: [uml-devel] Re: [patch] uml fixes, 2.6.1-mm5-A2
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
Date: Fri, 23 Jan 2004 08:56:47 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Jan 23, 2004 at 10:35:41AM +0100, Ingo Molnar wrote:
> hm, there's this code in arch/um/sys-i386/bugs.c:arch_handle_signal():
> 
>         ip = UPT_IP(regs);
>         if((*((char *) ip) != 0x0f) || ((*((char *) (ip + 1)) & 0xf0) != 0x40))
>                 return(0);
> 
> we are running in the UML kernel context here. Is the dereferencing of
> IP safe? 

No, it's not.  There needs to be a copy_from_user in there.

				Jeff


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
