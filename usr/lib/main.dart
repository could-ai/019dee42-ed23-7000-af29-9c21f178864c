import 'package:flutter/material.dart';

void main() {
  runApp(const PresentationApp());
}

class PresentationApp extends StatelessWidget {
  const PresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corporate Presentation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F4C81), // Classic Blue
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationViewer(),
      },
    );
  }
}

class PresentationViewer extends StatefulWidget {
  const PresentationViewer({super.key});

  @override
  State<PresentationViewer> createState() => _PresentationViewerState();
}

class _PresentationViewerState extends State<PresentationViewer> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<SlideData> _slides = [
    SlideData(
      title: "Corporate Profile",
      subtitle: "Excellence in Manufacturing & Innovation",
      content: "Welcome to our interactive corporate presentation.\nSwipe left or use the navigation buttons to explore our facilities, processes, and commitment to quality.",
      icon: Icons.business,
      isTitleSlide: true,
    ),
    SlideData(
      title: "Company Overview",
      content: "• Established in 1998 with a vision to lead the apparel industry.\n• Global footprint with exports to over 50 countries.\n• Core values: Integrity, Innovation, and Sustainability.\n• Over 10,000 skilled employees driving growth.",
      icon: Icons.info_outline,
    ),
    SlideData(
      title: "Management System",
      content: "• ISO 9001:2015 Certified Quality Management System.\n• Flat hierarchical structure for agile decision making.\n• Continuous employee training and development programs.\n• Robust ERP system for end-to-end supply chain visibility.",
      icon: Icons.account_tree_outlined,
    ),
    SlideData(
      title: "Machine Specification",
      content: "• State-of-the-art automated cutting machines (Lectra/Gerber).\n• Over 5,000 high-speed sewing machines (Juki, Brother).\n• Automated pocket setters and laser cutting technology.\n• Real-time machine IoT monitoring for predictive maintenance.",
      icon: Icons.precision_manufacturing_outlined,
    ),
    SlideData(
      title: "Raw Material",
      content: "• Sourcing from certified sustainable global suppliers.\n• 100% inspection of incoming fabrics (4-point system).\n• Focus on Organic Cotton, Recycled Polyester, and Tencel.\n• In-house testing lab for colorfastness and shrinkage.",
      icon: Icons.inventory_2_outlined,
    ),
    SlideData(
      title: "Production Process",
      content: "1. CAD Pattern Making & Marker Planning\n2. Automated Spreading & Cutting\n3. Modular Sewing Lines (Lean Manufacturing)\n4. Inline & End-of-line Quality Inspection\n5. Finishing & Packing",
      icon: Icons.schema_outlined,
    ),
    SlideData(
      title: "ETP (Effluent Treatment Plant)",
      content: "• Biological and Chemical treatment facilities.\n• Capacity of 2 Million Liters per day.\n• Zero Liquid Discharge (ZLD) implementation.\n• Real-time monitoring of pH, BOD, and COD levels.",
      icon: Icons.water_drop_outlined,
    ),
    SlideData(
      title: "Merchandising",
      content: "• Dedicated account managers for global brands.\n• Fast track sampling and proto development.\n• Critical Path Method (CPM) for on-time delivery.\n• Transparent costings and proactive communication.",
      icon: Icons.support_agent,
    ),
    SlideData(
      title: "Washing R&D Unit",
      content: "• Innovative sustainable wash developments (Ozone, Laser).\n• E-Flow technology reducing water usage by 80%.\n• Dedicated team for new trend analysis and sample replication.\n• Chemical compliance with ZDHC standards.",
      icon: Icons.science_outlined,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Presentation: ${_currentPage + 1} / ${_slides.length}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  return SlideWidget(slide: _slides[index]);
                },
              ),
            ),
            _buildBottomControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: _currentPage > 0 ? _previousPage : null,
            icon: const Icon(Icons.arrow_back),
            label: const Text('Previous'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
          Row(
            children: List.generate(
              _slides.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: _currentPage == index ? 24.0 : 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _currentPage < _slides.length - 1 ? _nextPage : null,
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Next'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class SlideData {
  final String title;
  final String? subtitle;
  final String content;
  final IconData icon;
  final bool isTitleSlide;

  SlideData({
    required this.title,
    this.subtitle,
    required this.content,
    required this.icon,
    this.isTitleSlide = false,
  });
}

class SlideWidget extends StatelessWidget {
  final SlideData slide;

  const SlideWidget({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    if (slide.isTitleSlide) {
      return _buildTitleSlide(context);
    }
    return _buildContentSlide(context);
  }

  Widget _buildTitleSlide(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(32.0),
        padding: const EdgeInsets.all(48.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              slide.icon,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 32),
            Text(
              slide.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            if (slide.subtitle != null) ...[
              const SizedBox(height: 16),
              Text(
                slide.subtitle!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
            ],
            const SizedBox(height: 48),
            Text(
              slide.content,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSlide(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Container(
      margin: EdgeInsets.all(isDesktop ? 48.0 : 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Slide Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  width: 2,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    slide.icon,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Text(
                    slide.title,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Slide Body
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildTextContent(context)),
                        const SizedBox(width: 48),
                        Expanded(child: _buildMediaPlaceholder(context)),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(child: _buildTextContent(context)),
                        const SizedBox(height: 24),
                        Expanded(child: _buildMediaPlaceholder(context)),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return SingleChildScrollView(
      child: Text(
        slide.content,
        style: const TextStyle(
          fontSize: 22,
          height: 1.8,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildMediaPlaceholder(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background pattern
          Opacity(
            opacity: 0.05,
            child: Icon(
              slide.icon,
              size: 200,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.picture_as_pdf, size: 48, color: Colors.red[400]),
                  const SizedBox(width: 16),
                  Icon(Icons.image, size: 48, color: Colors.blue[400]),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'PDF / Image Placeholder\n(${slide.title} Media)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
