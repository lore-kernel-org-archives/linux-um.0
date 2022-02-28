Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nOY9J-00AnqO-1M
 for linux-um@lists.infradead.org; Mon, 28 Feb 2022 05:00:42 +0000
Received: by mail-pl1-x62d.google.com with SMTP id z11so1306408pla.7
 for <linux-um@lists.infradead.org>; Sun, 27 Feb 2022 21:00:39 -0800 (PST)
Date: Sun, 27 Feb 2022 21:00:35 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: samsung-keypad - Properly state IOMEM dependency
Message-ID: <YhxW89ZYH6KgruvI@google.com>
References: <20220225041727.1902850-1-davidgow@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220225041727.1902850-1-davidgow@google.com>
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
To: David Gow <davidgow@google.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, anton ivanov <anton.ivanov@cambridgegreys.com>

On Fri, Feb 25, 2022 at 12:17:27PM +0800, David Gow wrote:
> Make the samsung-keypad driver explicitly depend on CONFIG_HAS_IOMEM, as it
> calls devm_ioremap(). This prevents compile errors in some configs (e.g,
> allyesconfig/randconfig under UML):
> 
> /usr/bin/ld: drivers/input/keyboard/samsung-keypad.o: in function `samsung_keypad_probe':
> samsung-keypad.c:(.text+0xc60): undefined reference to `devm_ioremap'
> 
> Signed-off-by: David Gow <davidgow@google.com>
> Acked-by: anton ivanov <anton.ivanov@cambridgegreys.com>

Applied, thank you.

-- 
Dmitry

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

