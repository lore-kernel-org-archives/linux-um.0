Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Au80s-00039g-J7
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 20 Feb 2004 02:36:06 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Au7mQ-00072p-T5
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 20 Feb 2004 02:21:11 -0800
References: <40338C1B.1070800@meisterwerk.net> <c1360l$eei$1@sea.gmane.org>
From: Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <c1360l$eei$1@sea.gmane.org>
Message-ID: <87llmy3vr5.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [uml-devel] Re: skas3 patch fails against vanilla-2.4.25
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: 20 Feb 2004 11:12:14 +0100
Content-Transfer-Encoding: 8bit
To: Sven =?iso-8859-1?q?K=F6hler?= <skoehler@upb.de>, user-mode-linux-devel@lists.sourceforge.net

Sven Köhler <skoehler@upb.de> writes:

> Than i applied the SKAS-patch by Gerd Knorr from
>    http://www.suse.de/~kraxel/uml/patches/
> and guess what happened when i tried to compile my host-kernel:
> 
>    LD      .tmp_vmlinux1
> mm/built-in.o(.text+0x1d86f): In function `write_proc_mm':

You didn't apply the second patch, did you?

  Gerd



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id56&alloc_id438&op�k
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
