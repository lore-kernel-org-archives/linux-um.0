Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1302698512-11979-2-git-send-email-richard@nod.at>
References: <1302698512-11979-1-git-send-email-richard@nod.at>
	<1302698512-11979-2-git-send-email-richard@nod.at>
Date: Wed, 13 Apr 2011 15:56:26 +0300
Message-ID: <BANLkTikJ-7vHBBWSdTcz4mtB2ERqfn3D6g@mail.gmail.com>
From: Pekka Enberg <penberg@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 2/2] um: Disable CONFIG_CMPXCHG_LOCAL
To: Richard Weinberger <richard@nod.at>
Cc: akpm@linux-foundation.com, slyich@gmail.com, linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Apr 13, 2011 at 3:41 PM, Richard Weinberger <richard@nod.at> wrote:
> Commit 8a5ec0ba "Lockless (and preemptless) fastpaths for slub"
> makes use of this_cpu_cmpxchg_double() which needs
> this_cpu_cmpxchg16b_emu() on x86_64.
> Implementing cmpxchg16b emulation for UML would introduce
> too much complexity. So just disable it.
>
> LKML-Reference: <20110412192014.GF16342@mtj.dyndns.org>
> Reported-by: Sergei Trofimovich <slyich@gmail.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Acked-by: Pekka Enberg <penberg@kernel.org>
