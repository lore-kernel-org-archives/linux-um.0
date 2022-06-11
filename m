Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o09G1-00Egn5-LB
	for linux-um@lists.infradead.org; Sat, 11 Jun 2022 22:07:05 +0000
Received: by mail-vs1-xe2c.google.com with SMTP id f13so2551678vsp.1
        for <linux-um@lists.infradead.org>; Sat, 11 Jun 2022 15:07:00 -0700 (PDT)
Date: Sat, 11 Jun 2022 17:06:49 -0500
From: Glenn Washburn <development@efficientek.com>
Subject: Undesirable preprocessor options passed when building modules
Message-ID: <20220611170649.7cdf709f@crass-HP-ZBook-15-G2>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: development@efficientek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um <linux-um@lists.infradead.org>
Cc: development@efficientek.com

Hi,

When building an out of tree module (I expect it happens in tree as
well) for ARCH=um, I'm seeing options like -Dsetjmp=kernel_setjmp being
sent to the compiler. This is causing the zfs[1] kernel module to fail
to build because it uses a function internally called setjmp. Usually
this wouldn't be a problem because both the definition and calls for
setjmp would be renamed. However, setjmp is defined in an assembly file
and so is not getting renamed, causing modpost to bork because it can't
find the symbol named "kernel_setjmp".

I've fixed this in the zfs code base by using "#undef setjmp" when
CONFIG_UML_X86 is defined. But I'm thinking a better fix would be for
the ARCH=um build to not send these name redefinitions in the first
place. I'm thinking a possible solution is to only send those options
to the compiler when not compiling module code or even better only code
under arch/um. Or would this be too much of a pain to fix?

Glenn

[1] https://zfsonlinux.org/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

