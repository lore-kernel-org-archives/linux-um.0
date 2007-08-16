Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILlKx-0002SG-1W for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 12:48:55 -0700
Received: from sr04-05.mta.terra.com.br ([200.154.152.54])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ILlKt-0006HD-NS
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 12:48:53 -0700
Date: Thu, 16 Aug 2007 16:48:43 -0300
Message-Id: <JMVTP7$E1B1C27F58AFF22330472C8DFD9A4C5B@multidominios>
MIME-Version: 1.0
From: "Alberto Pires de Oliveira Neto" <apon1@terra.com.br>
Subject: Re: [uml-devel] [Spam] Re: [PATCH] UML - Add a .note.SuSE section
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike <jdike@addtoit.com>
Cc: akpm <akpm@osdl.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, giedrius <giedrius@su.lt>, linux-kernel <linux-kernel@vger.kernel.org>, stable <stable@kernel.org>, arjan <arjan@infradead.org>

Hi Jeff,

  I'm really sorry, but I forget to mention, that I had the same problems on a RedHat RH4 (x86_64) too. 

> On Thu, Aug 16, 2007 at 09:30:56AM -0700, Arjan van de Ven wrote:
> > this sounds like something really stupid and bad... why would the kernel
> > need to have a per-distro note section???
> 
> On Thu, Aug 16, 2007 at 09:39:06AM -0700, Chris Wright wrote:
> > Huh!?  Why do we need a SuSE section?
> 
> On Thu, Aug 16, 2007 at 09:54:55AM -0700, Greg KH wrote:
> > I agree, what did we mess up in the SuSE kernel to require such a hack?
> 
> Beats the crap out of me.
> 
> Drop this patch - it looks like it might just be papering over
> symptoms rather than fixing the real problem - see below.
> 
> What I do know is that current UML doesn't run when built on a SuSE
> host, the UML commit which caused it to break is
> c35e584c087381aaa5f1ed40a28b978535c18fb2 
> 
> 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c35e584c087381aaa5f1ed40a28b978535c18fb2;hp=a5bd1786fb30abe663b904f6d79bba413e9ba883
> 
> and the difference between a working UML binary and a broken one is
> this:
> 
> +  1 .note.ABI-tag 00000020  0000000060000254  0000000060000254  00000254  2**2
> +                  CONTENTS, ALLOC, LOAD, READONLY, DATA
> +  2 .note.SuSE    00000018  0000000060000274  0000000060000274  00000274  2**2
> +                  CONTENTS, ALLOC, LOAD, READONLY, DATA
> 
> and the .note.SuSE section makes the difference.
> 
> Looking into it a bit further, the contents of the section are:
> 
> 	objdump --section=.note.SuSE -s uml8796-linux-good
> 
> 	uml8796-linux-good:     file format elf64-x86-64
> 
> 	Contents of section .note.SuSE:
> 	 60000274 05000000 04000000 53755345 53755345  ........SuSESuSE
> 	 60000284 00000000 01000a02                    ........        
> 
> which seems kind of pointless, but also harmless.
> 
> The crash is in this section:
> 
>   __uml_setup_start = .;
>   .uml.setup.init : { *(.uml.setup.init) }
>   __uml_setup_end = .;
> 
> with &__uml_setup_start being 8 bytes before the start of the first
> 16-byte structure in .uml.setup.init, so the structures are misaligned
> wrt the start symbol.
> 
> I don't see any connection between the presence of a section at the
> start of the binary and this misalignment, so the patch is probably wrong.
> 
> 				Jeff
> 
> -- 
> Work email - jdike at linux dot intel dot com
> 
> E-mail classificado pelo Identificador de Spam Inteligente Terra.
> Para alterar a categoria classificada, visite
>
http://mail.terra.com.br/cgi-bin/imail.cgi?+_u=apon1&_l=1,1187292509.393134.20591.domoni.hst.terra.com.br,4040,20031127114101,20031127114101
> 
> Esta mensagem foi verificada pelo E-mail Protegido Terra.
> Scan engine: McAfee VirusScan / Atualizado em 16/08/2007 / Vers?o: 5.1.00/5099
> Proteja o seu e-mail Terra: http://mail.terra.com.br/
> 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
