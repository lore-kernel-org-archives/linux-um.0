Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Mon, 1 Aug 2011 19:20:15 +0200
References: <201108011541.59640.richard@nod.at> <43e4e9e98b32d3d3eb06ab837a019ad8@localhost> <20110801171042.GA25954@albatros>
In-Reply-To: <20110801171042.GA25954@albatros>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201108011920.15972.richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: shm updates broke UML
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: Marc Zyngier <maz@misterjones.org>, serge.hallyn@canonical.com, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, toralf.foerster@gmx.de
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Montag 01 August 2011 19:10:42 Vasiliy Kulikov wrote:
> On Mon, Aug 01, 2011 at 18:01 +0200, Marc Zyngier wrote:
> > It also breaks ARM (at least 11MPCore and Cortex A9).
> > The same workaround gets the kernel booting again.
> 
> Can you please apply this patch and show the output?
> I suppose all numbers will be nonNULL and the last is NULL.

true. :-)

ns = 0824cc44, ids = 0824cc90
wait_list = 0824cc9c
next =   (null)

Thanks,
//richard
