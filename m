Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 29 Aug 2011 12:35:41 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
In-Reply-To: <1314634419-24766-2-git-send-email-richard@nod.at>
Message-ID: <alpine.DEB.2.00.1108291235180.16005@router.home>
References: <1314634419-24766-1-git-send-email-richard@nod.at> <1314634419-24766-2-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/9] um: disable CMPXCHG_DOUBLE as it breaks UML build
To: Richard Weinberger <richard@nod.at>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, 29 Aug 2011, Richard Weinberger wrote:

> Commit b789ef518b2a7231b0668c813f677cee528a9d3f tests for cmpxchg_double
> support in the SLUB code and it breaks UML builds with SLUB. Since UML
> does not support checking for CPU features, disable CMPXCHG_DOUBLE just
> like CMPXCHG_LOCAL is disabled for UML.

Reviewed-by: Christoph Lameter <cl@linux.com>
