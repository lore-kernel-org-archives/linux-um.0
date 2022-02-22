Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMU0k-009Vll-8j
 for linux-um@lists.infradead.org; Tue, 22 Feb 2022 12:11:19 +0000
Message-ID: <c70a79c3996ef58320e8265c8e1dc89a8b0b2e6d.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Fix uml_mconsole stop/go
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 22 Feb 2022 13:11:09 +0100
In-Reply-To: <20220222105756.1354219-1-anton.ivanov@cambridgegreys.com>
References: <20220222105756.1354219-1-anton.ivanov@cambridgegreys.com>
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
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: rrs@debian.org, 1005900@bugs.debian.org, quake2iasi@gmail.com, richard@nod.at

On Tue, 2022-02-22 at 10:57 +0000, anton.ivanov@cambridgegreys.com
wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Moving to an EPOLL based IRQ controller broke uml_mconsole stop/go
> commands. This fixes it and restores stop/go functionality.
> 
> Fixes: ff6a17989c08b0bb0fd490cc500b084581b3a9b9 Epoll based IRQ controller

The right format would be

Fixes: ff6a17989c08 ("Epoll based IRQ controller")

Don't think I can comment on the patch itself, sorry.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

