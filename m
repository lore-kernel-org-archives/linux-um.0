Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 12 Apr 2011 13:10:37 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
In-Reply-To: <201104121609.56901.richard@nod.at>
Message-ID: <alpine.DEB.2.00.1104121309480.14692@router.home>
References: <201104121609.56901.richard@nod.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: um: this_cpu_cmpxchg16b_emu
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, penberg@kernel.org, hpa@zytor.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, 12 Apr 2011, Richard Weinberger wrote:

> This patch implements this_cpu_cmpxchg16b_emu() for UML.

Is this really necessary? Just undefine CONFIG_CMPXCHG_LOCAL for UML and
the asm code will not be used.

