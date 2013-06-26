Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <51CA9EB3.1070201@asianux.com>
Date: Wed, 26 Jun 2013 15:56:35 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
References: <51CA8AB8.7080504@asianux.com> <51CA900E.9020407@nod.at> <CAMuHMdU-eWL-PtR64pdXw3mpjHxdx7Geym29E5KpATSe5QvBEg@mail.gmail.com>
In-Reply-To: <CAMuHMdU-eWL-PtR64pdXw3mpjHxdx7Geym29E5KpATSe5QvBEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Subject: Re: [PATCH] include/asm-generic/io.h: add 'UML' case just like 'no-MMU'
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Arnd Bergmann <arnd@arndb.de>, David Sharp <dhsharp@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 06/26/2013 03:38 PM, Geert Uytterhoeven wrote:
> On Wed, Jun 26, 2013 at 8:54 AM, Richard Weinberger <richard@nod.at> wrote:
>>> >> -#ifndef CONFIG_MMU
>>> >> +#if !CONFIG_MMU || CONFIG_UML
> FWIW, the above syntax is not correct, it should be
> 
> #if !defined(CONFIG_MMU) || defined(CONFIG_UML)
> 

Oh, really it is.  :-)


Thanks.
-- 
Chen Gang

Asianux Corporation
