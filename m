Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GqGLV-0007oL-Dw for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Dec 2006 13:55:01 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user64418)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GqGLU-0006mG-Mh
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Dec 2006 13:55:01 -0800
References: <87wt5h9azl.fsf@hades.wkstn.nix>
	<200611291706.42798.blaisorblade@yahoo.it>
	<873b7zy7ce.fsf@hades.wkstn.nix>
From: Nix <nix@esperi.org.uk>
Date: Fri, 01 Dec 2006 21:54:56 +0000
In-Reply-To: <873b7zy7ce.fsf@hades.wkstn.nix> (nix@esperi.org.uk's message of
	"Fri, 01 Dec 2006 15:16:33 +0000")
Message-ID: <87zma7ffin.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] PATCH [02/03]: eliminate skas_ptrace.h
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 1 Dec 2006, nix@esperi.org.uk uttered the following:

> On 29 Nov 2006, blaisorblade@yahoo.it uttered the following:
>> arch/um/os-Linux/start_up.o is in USER_OBJS, so it is compiled against host 
>> headers.
>> You cannot _depend_ on them including the SKAS patch, as I said. And that 
>> header is in arch/um/include to be includable by both kernelspace and 
>> userspace files...
>
> Oh, hell, true. The problem is that we'll have to cater for people who
> *have* included the skas headers, including the old ones...

No we won't: kernel building includes things from the Linux source
tree's includes directory, not /usr/include/asm, so what people have in
/usr/include/asm/ptrace.h should be irrelevant.

(I have now reproduced this failure both with and without the skas patch
in the headers installed via `make headers_install'.)

Or is it that userspace stuff includes /usr/include/asm/*, kernelspace
stuff includes include/asm-{whatever} from the kernel tree, but nothing
includes both, so we need *some* things in some third location where
both can see them?

(If that's so, I don't see how my patch built at all. Hm.)

-- 
`The main high-level difference between Emacs and (say) UNIX, Windows,
 or BeOS... is that Emacs boots quicker.' --- PdS

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
