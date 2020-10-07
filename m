Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQBFO-0002nU-Sj
 for linux-um@lists.infradead.org; Wed, 07 Oct 2020 15:20:55 +0000
Message-ID: <0ed761fbe77f9858244ee2ffbf3e700d7df78418.camel@sipsolutions.net>
Subject: Re: [RFC v7 03/21] um: move arch/um/os-Linux dir to tools/um/uml
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 07 Oct 2020 17:20:46 +0200
In-Reply-To: <d5df1b8807384a00f96e4b02d41a37183fad5562.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
 <d5df1b8807384a00f96e4b02d41a37183fad5562.1601960644.git.thehajime@gmail.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, retrage01@gmail.com, linux-arch@vger.kernel.org

On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> This patch moves underlying OS dependent part under arch/um to tools/um
> directory so that arch/um code does not need to build host build
> facilities (e.g., libc).

Hmm. On the one hand, that build separation seems sensible, but on the
other hand this stuff *does* fundamentally belong to arch/um/, and it's
not a "tool" like basically everything else there that is a pure
userspace application to run *inside* the kernel, not *part of* it.

For that reason, I don't really like this much.


>  tools/um/uml/Build                            | 48 +++++++++++++++++++
>  tools/um/uml/drivers/Build                    | 10 ++++

Also, what's with the names here? What's wrong with "Makefile"?


I'm also not sure I see how this is built at all from the top level
Makefile? Oh. I think Anton said it doesn't ... that alone would be a
reason not to do it I guess.


So why do you think it must be under tools/? Even if you consider "lkl"
a "tool", that doesn't mean it must be there. I also consider a UML
binary ("linux") a "tool" in my simulation environment, etc.


And even LKL, which is the eventual goal here - why would you consider
that a "tool"? I don't think we should.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

