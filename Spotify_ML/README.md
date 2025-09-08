# 🎵 MelodyMind: Teaching Models to Feel Music

| Project Detail | Data Link | Report Link |
|:---------------:|:---------:|:---------:|
| [MelodyMind](https://github.com/J-hjr/Jerry_Huang_DS_Project_Portfolio/tree/main/Spotify_ML) | [Link](https://drive.google.com/drive/folders/1fTegCMoLUX1kmEcOu6uF1shaHXY8ZbeZ) | [Report Link](https://drive.google.com/drive/folders/1iqr5GBJ63totAOcuIC9Fm7XpxEzZ0Azy)

## 🎧 Intro: Data with Soul

When I started this project, I wasn't just building another machine learning model: I was teaching a computer to *feel* music the way we do. Every song tells a story, and I wanted to help **Machine Learning Models** understand that story through the language of audio features.

This project explores how we can bridge the gap between human musical intuition and machine learning algorithms, creating systems that don't just classify music, but *understand* it.

## 🚀 Mission

Music streaming platforms like Spotify have millions of songs, but how do they know what makes a jazz track different from electronic music? How can we teach machines to recognize the soul in a blues guitar solo or the energy in a hip-hop beat?

I set out to build a system that could:

- **Listen** to music the way humans do
- **Understand** the subtle differences between genres
- **Learn** from 50,000 songs across 10 different musical styles
- **Predict** what genre a song belongs to with human-like accuracy

## 🎼 The Music That Taught Me

**Data Source**: Spotify Music Database

**Size**: 50,000 songs (5,000 per genre)

**Genres**: Alternative, Anime, Blues, Classical, Country, Electronic, Hip-Hop, Jazz, Rap, Rock

### What Makes Each Song Unique:

- **The Soul**: danceability, energy, acousticness, instrumentalness, valence
- **The Rhythm**: tempo, loudness, speechiness, liveness
- **The Story**: popularity, duration, key, mode

> This wasn't just data. It was 50,000 musical stories waiting to be understood. Each song had its own personality, its own way of making people feel, and I wanted to teach Machine Learning Models to recognize that personality.
> 

## 🔧 What I Built

### 🎯 1. **The Art of Listening (Data Preprocessing)**

- Cleaned and prepared **50,000 songs** from Spotify's database, handling missing values and inconsistencies with care
- Transformed raw audio features into a language that machines could understand
- Used **Python** and `pandas` to ensure every song's story was preserved in the data

### 🧠 2. **Teaching AI to See Music (Dimensionality Reduction)**

- **PCA**: Showed AI the big picture—how genres differ globally
- **t-SNE**: Helped AI understand the subtle relationships between similar songs
- **UMAP**: Balanced both perspectives for deeper musical insights
- **LDA**: Used genre labels to teach AI the most important differences

### 🎵 3. **The Learning Process (Machine Learning Models)**

- Trained **7 different algorithms** to find the best way to "hear" music
- **Random Forest**: The reliable friend (62.3% accuracy)
- **Neural Networks**: The deep thinker (92.9% AUC)
- **XGBoost**: The balanced performer
- Each model learned to recognize music in its own unique way

### 📊 4. **Making Music Visible (Visualization & Analysis)**

- Created visualizations that showed how different genres cluster together
- Built dashboards that revealed the hidden patterns in music
- Discovered what makes each genre special through data storytelling

## 💡 Key Discoveries

### 🎼 What I Learned About Music

Through this journey, I discovered that each genre has its own musical DNA:

- **Classical Music**: The soulful storyteller (high acousticness, low energy, longer duration)
- **Electronic Music**: The energetic innovator (high energy, low acousticness, synthetic sounds)
- **Hip-Hop**: The rhythmic poet (high speechiness, moderate energy, rhythmic patterns)
- **Jazz**: The complex artist (moderate energy, high instrumentalness, complex harmonies)

### 🧠 What I Learned About AI

The best-performing model achieved **92.9% AUC** using a neural network—not just impressive numbers, but proof that AI can learn to feel music almost as well as we do.

### 🌟 The Real Magic

This wasn't just about building a classifier. It was about:

- **Understanding** how music touches our souls
- **Teaching** machines to recognize emotion in sound
- **Creating** systems that could help people discover music they'll love
- **Bridging** the gap between human creativity and artificial intelligence

> The best music classification isn't just accurate, as it could be humanized. It understands that a blues guitar solo and a jazz saxophone solo are different kinds of soul, even if they share similar technical features.
> 

## 🎓 What This Taught Me

### The Art of Listening

This project taught me that data analysis isn't just about numbers—it's about understanding the stories behind the data. Working with music data showed me how to find meaning in patterns and translate technical insights into human understanding.

### The Science of Feeling

I learned to build systems that don't just process information, but *understand* it. Teaching AI to recognize musical emotion taught me that the best technology is the kind that feels human.

### The Power of Storytelling

Through visualization and analysis, I discovered how to make complex data tell compelling stories. Every chart, every insight became a way to share the magic of music with others.

### The Bridge Between Art and Science

This project showed me how to balance technical precision with creative intuition—how to build systems that respect both the art of music and the science of data.

## 🛠️ The Technical Journey

### Tools That Made It Possible

- **Python**: The language that let me speak to music data
- **Jupyter Notebook**: My creative canvas for exploration
- **Pandas & NumPy**: The tools that helped me understand 50,000 songs
- **Scikit-learn**: The algorithms that learned to feel music
- **Matplotlib & Seaborn**: The brushes that painted data stories
- **XGBoost**: The ensemble method that brought it all together

### The Process

1. **Listening**: Clean and prepare audio features with care
2. **Understanding**: Explore patterns and relationships in the data
3. **Seeing**: Use dimensionality reduction to visualize musical landscapes
4. **Learning**: Train multiple algorithms to find the best approach
5. **Evaluating**: Measure success not just by accuracy, but by understanding
6. **Sharing**: Create visualizations that tell the story of music

## 🌟 The Bigger Picture

This project showed me that the future of music technology isn't just about better algorithms—it's about creating systems that understand the human experience of music. Every song has a story, and models can help us tell those stories better.

> This was not only a machine learning project, but was a journey into understanding how technology can connect with the most human part of us: our love for music.
> 

## 🚀 Ready to Explore?

### Prerequisites

```bash
pip install pandas numpy matplotlib seaborn scikit-learn xgboost umap-learn jupyter
```

### How to Start Your Own Journey

1. Clone this repository
2. Open `Jerry_Huang_Spotify.ipynb` in Jupyter Notebook
3. Run all cells to see the magic unfold
4. Let the music data tell you its story

### What You'll Find

```
├── Jerry_Huang_Spotify.ipynb    # The complete musical journey
├── musicData.csv                     # 50,000 songs waiting to be heard
├── Jerry_Huang_Spotify_report.pdf    # The full story in detail
└── README.md                         # This file
```

## About the Creator

**Jerry Huang**

*New York University*

*Data Science & Computer Science + Music*

*"Every data point has a story. My job is to help that story be heard."*

## 🙏 Acknowledgments

- **Spotify** for sharing the music that taught me
- **The open source community** for building the tools that made this possible
- **NYU professor** for guiding me on this journey
- **Every musician** whose work became part of this story

---

*This project isn't just about teaching Machine Learning Models to classify music: it's about understanding how technology can connect with the most human part of us: our love for music.*