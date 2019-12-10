Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieasR-0005CQ-5c
 for linux-um@lists.infradead.org; Tue, 10 Dec 2019 08:28:16 +0000
Message-ID: <7da5a054f533eabf2ffa110c236f011bf9d23954.camel@sipsolutions.net>
Subject: Re: [PATCH v1] uml: remove support for CONFIG_STATIC_LINK
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 10 Dec 2019 09:28:01 +0100
In-Reply-To: <346757c8-c111-f6cf-21d2-b0bffd41b8a8@cambridgegreys.com>
References: <20191209230248.227508-1-brendanhiggins@google.com>
 <1406826345.111805.1575933346955.JavaMail.zimbra@nod.at>
 <2eecf4dc-eb96-859a-a015-1a4f388b57a2@cambridgegreys.com>
 <346757c8-c111-f6cf-21d2-b0bffd41b8a8@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Richard Weinberger <richard@nod.at>, Brendan Higgins <brendanhiggins@google.com>
Cc: Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, davidgow@google.com

On Tue, 2019-12-10 at 07:34 +0000, Anton Ivanov wrote:

> > Further to this - any properly written piece of networking code which 
> > uses the newer functions for name/service resolution will have the same 
> > problem. You can be static only if you do everything "manually" the old 
> > way.
> 
> The offending piece of code is the glibc implementation of getaddrinfo().
> 
> If you use it and link static the resulting binary is not really static.

However, this (getaddrinfo) really only applies if you use the vector
network driver, if you e.g. use only virtio then this particular problem
isn't present.

Note sure if we implicitly call getaddrinfo from libpcap, but again,
that's just a single driver.

IOW, we could just make CONFIG_STATIC_LINK depend on !VECTOR && !PCAP?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

