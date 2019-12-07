Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1idOpl-0003k8-RI
 for linux-um@lists.infradead.org; Sat, 07 Dec 2019 01:24:35 +0000
Received: by mail-pl1-x649.google.com with SMTP id s6so4393522plq.3
 for <linux-um@lists.infradead.org>; Fri, 06 Dec 2019 17:24:32 -0800 (PST)
Date: Fri,  6 Dec 2019 17:24:01 -0800
In-Reply-To: <20191016141312.15684-1-anton.ivanov@cambridgegreys.com>
Message-Id: <20191207012401.222282-1-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191016141312.15684-1-anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH] um: Add back support for extra userspace libraries
From: Brendan Higgins <brendanhiggins@google.com>
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: Brendan Higgins <brendanhiggins@google.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, johannes.berg@intel.com

> PCAP and VDE network transports require linking with userspace
> libraries. The current build system has no means of passing these
> as arguments.
>
> This patch adds a script to expand the library list for linking
> for these transports as well as any future driver that needs to
> rely on additional libraries on the userspace side.
>
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

