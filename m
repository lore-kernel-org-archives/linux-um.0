Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bowdn-00059z-W8 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jul 2004 20:59:07 -0700
Received: from out-mta1.plasa.com ([202.134.0.37])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bowdn-0001ve-2R for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jul 2004 20:59:07 -0700
From: "Mulyadi-Santosa" <a_mulyadi@telkom.net>
Subject: Re: [uml-devel] Kallsyms on UML
Message-ID: <web-1072592@b1.c.plasa.com>
In-Reply-To: <20040726002724.GA11374@kevlar.burdell.org>
References: <20040726002724.GA11374@kevlar.burdell.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format="flowed"
Content-Transfer-Encoding: 8bit
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
Date: Mon, 26 Jul 2004 10:57:05 +0700
To: Sonny Rao <sonny@burdell.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hello Sonny

> I had one question, I noticed that on stack traces I'm 
>not getting
> symbols even though I had CONFIG_KALLSYMS enabled.  I 
>looked into it a
> bit more and it appears that the kernel build system is 

Ehm, have you done EXPORT_SYMBOL(your_proc) or 
EXPORT_SYMBOL(your_variable). I am not sure is this what 
you want, but I do this on my trial kernel module (well, I 
am still kernel newbie after all :-)) )

Hope it helps

regards

Mulyadi
===========================================================================================
Netkuis Instan untuk wilayah Bandung (kode area 022) - SD,SMP,SMA berhadiah total puluhan juta rupiah... periode I dimulai 1 April 2004
===========================================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
