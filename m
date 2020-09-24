Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ms.lwn.net ([2600:3c01:e000:3a1::42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLUVS-0007GH-Qe
 for linux-um@lists.infradead.org; Thu, 24 Sep 2020 16:54:07 +0000
Date: Thu, 24 Sep 2020 10:54:02 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4] docs: replace the old User Mode Linux HowTo with a
 new one
Message-ID: <20200924105402.5615d626@lwn.net>
In-Reply-To: <20200917103557.26063-1-anton.ivanov@cambridgegreys.com>
References: <20200917103557.26063-1-anton.ivanov@cambridgegreys.com>
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
To: anton.ivanov@cambridgegreys.com
Cc: richard@nod.at, linux-um@lists.infradead.org, linux-doc@vger.kernel.org

On Thu, 17 Sep 2020 11:35:57 +0100
anton.ivanov@cambridgegreys.com wrote:

> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> The new HowTo migrates the portions of the old howto which
> are still relevant to a new document, updates them to linux 5.x
> and adds documentation for vector transports and other new
> features.
> 
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>  Documentation/virt/index.rst                  |    2 +-
>  Documentation/virt/uml/user_mode_linux.rst    | 4403 -----------------
>  .../virt/uml/user_mode_linux_howto_v2.rst     | 1208 +++++
>  3 files changed, 1209 insertions(+), 4404 deletions(-)
>  delete mode 100644 Documentation/virt/uml/user_mode_linux.rst
>  create mode 100644 Documentation/virt/uml/user_mode_linux_howto_v2.rst

Applied, thanks.

jon

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

