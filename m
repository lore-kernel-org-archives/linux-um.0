Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: kbuild: ARCH=um archheaders failed
From: Randy Dunlap <rdunlap@infradead.org>
References: <be4f41de-c27a-abac-4b23-369c400e016e@infradead.org>
Message-ID: <861c26a6-294c-755d-2396-e5d18b9bbcbf@infradead.org>
Date: Fri, 3 Aug 2018 08:41:22 -0700
MIME-Version: 1.0
In-Reply-To: <be4f41de-c27a-abac-4b23-369c400e016e@infradead.org>
Content-Language: en-US
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
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kbuild <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org

On 08/02/2018 05:13 PM, Randy Dunlap wrote:
> Hi Yamada-san,
> 
> I see this every few weeks.  It's not reproducible (it depends
> on the moon, Mars, etc.).
> 
> I'm using O=builddir.  The build log is short (below).
> 
> Do you see a makefile problem here?  (nothing to do with mmotm;
> I see it more frequently with linux-next since I do many daily
> builds with it)

BTW, this is just um defconfig with -j4.

-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

